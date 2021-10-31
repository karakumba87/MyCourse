WITH cte AS (
            SELECT client_id, a_type, MAX(a_type) OVER(PARTITION BY client_id) AS max_a_type, 
                city, street, house, flat
                , CASE
                    WHEN city IS NULL  
                    THEN 0 ELSE 1 END 
                + CASE 
                    WHEN street IS NULL
                    THEN 0 ELSE 1 END 
                + CASE 
                    WHEN house  IS NULL
                    THEN 0 ELSE 1 END 
                + CASE 
                    WHEN flat   IS NULL  
                    THEN 0 ELSE 1 END
                AS address_fullness_rank,
                created, MAX(created) OVER(PARTITION BY client_id) AS max_created
            FROM address 
            WHERE active = 'Y'
            ),
    cte2 AS (
            SELECT address_fullness_rank, max_created, created, client_id, city, street, house, flat
                    , MAX(address_fullness_rank) OVER(PARTITION BY client_id) AS max_address_fullness_rank
					, MAX(created) OVER(PARTITION BY client_id, a_type) AS max_created_in_address
            FROM cte
            WHERE a_type = max_a_type
            )
          
SELECT DISTINCT name AS Name, city || ', ' || street || ', ' || house || ', ' || flat AS Address
                , like_phone.c_info AS "Phone", like_mail.c_info AS "Email"
FROM client INNER JOIN   (
                            SELECT client_id, c_info, created
                            , MAX(created) OVER(PARTITION BY client_id) AS max_created
                            FROM    contact
                            WHERE contact.active != 'N' AND c_type = 1
                            ) like_phone ON client.id = like_phone.client_id
            INNER JOIN   (
                            SELECT client_id, c_info, created
                            , MAX(created) OVER(PARTITION BY client_id) AS max_created
                            FROM  contact
                            WHERE contact.active != 'N' AND c_type = 2
                            ) like_mail ON client.id = like_mail.client_id
            INNER JOIN   cte2 ON client.id = cte2.client_id
WHERE like_phone.created = like_phone.max_created AND like_mail.created = like_mail.max_created
                                 AND address_fullness_rank = max_address_fullness_rank 
                                 AND cte2.created = max_created_in_address
;