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
					, MAX(created) OVER(PARTITION BY client_id, a_type, address_fullness_rank) AS max_created_in_address
            FROM cte
            WHERE a_type = max_a_type
            )
          
SELECT DISTINCT name AS Name
                , CASE
                    WHEN max_address_fullness_rank > 0
                    THEN city || ', ' || street || ', ' || house || ', ' || flat 
                    ELSE 'Отсутствует'
                END AS Address
                , CASE
                    WHEN like_phone.c_info IS NULL
                    THEN 'Отсутствует'
                    ELSE like_phone.c_info
                END AS "Phone"
                , CASE
                    WHEN like_mail.c_info IS NULL
                    THEN 'Отсутствует'
                    ELSE like_mail.c_info
                END AS "Email"
FROM client 
            LEFT JOIN   (
                            SELECT client_id, c_info, created
                            , MAX(created) OVER(PARTITION BY client_id) AS max_created
                            FROM    contact
                            WHERE contact.active != 'N' AND c_type = 1
                            ) like_phone ON client.id = like_phone.client_id
            LEFT JOIN   (
                            SELECT client_id, c_info, created
                            , MAX(created) OVER(PARTITION BY client_id) AS max_created
                            FROM  contact
                            WHERE contact.active != 'N' AND c_type = 2
                            ) like_mail ON client.id = like_mail.client_id
            LEFT JOIN   cte2 ON client.id = cte2.client_id
WHERE (like_phone.created = like_phone.max_created OR like_phone.created IS NULL) 
        AND (like_mail.created = like_mail.max_created OR like_mail.created IS NULL) 
        AND (address_fullness_rank = max_address_fullness_rank OR cte2.created IS NULL)
        AND (cte2.created = max_created_in_address OR cte2.created IS NULL)
;





-- Таблица: Client
CREATE TABLE Client (ID NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT client_pk PRIMARY KEY, Name VARCHAR2 (100));
INSERT INTO Client (Name) VALUES ('Букин');
INSERT INTO Client (Name) VALUES ('Правиков');
INSERT INTO Client (Name) VALUES ('Кошубаров');
INSERT INTO Client (Name) VALUES ('Альшин');


-- Таблица: Address
CREATE TABLE Address (ID NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT address_pk PRIMARY KEY, Client_id NUMBER, A_type NUMBER, City VARCHAR2 (100), Street VARCHAR2 (100), House VARCHAR2 (100), Flat VARCHAR2 (100), Created DATE, Active VARCHAR2 (1), CONSTRAINT FK_Client FOREIGN KEY (Client_id) REFERENCES Client(ID));
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 1, 'Саратов', 'Рабочая', '15', '', TO_DATE('2020.11.21', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 1, 'Саратов', 'Советская', '31', '20', TO_DATE('2020.11.20', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 3, 'Саратов', 'Тархова', '13', '14', TO_DATE('19-JAN-21', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 3, 'Саратов', 'Барнаульская', '12', '5', TO_DATE('20-JAN-21', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 3, 'Саратов', 'Затонская', '19', '56', TO_DATE('2021.01.29', 'YYYY/MM/DD'), 'N');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (2, 1, '', 'Бахметьевская', '23', '', TO_DATE('2020.01.13', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (2, 2, 'Саратов', 'Кутякова', '53', '333', TO_DATE('2020.05.24', 'YYYY/MM/DD'), 'N');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (2, 3, 'Саратов', 'Горная', '33', '52', TO_DATE('2021.02.02', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (3, 1, 'Саратов', 'Казачья', '19', '24', TO_DATE('2020.12.21', 'YYYY/MM/DD'), 'N');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (3, 2, '', 'Соколовая', '44', '1', TO_DATE('2019.11.16', 'YYYY/MM/DD'), 'Y');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (3, 3, 'Саратов', 'Аткарская', '31', '85', TO_DATE('2019.01.26', 'YYYY/MM/DD'), 'N');
INSERT INTO address (client_id, a_type, city, street, house, flat, created, active) VALUES (1, 1, '', 'Университетская', '33', '13', TO_DATE('2020.11.21', 'YYYY/MM/DD'), 'Y');


-- Таблица: Contact
CREATE TABLE Contact (ID NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT contact_pk PRIMARY KEY, Client_id NUMBER, C_type NUMBER, C_info VARCHAR2 (100), Created DATE, Active VARCHAR2 (1), CONSTRAINT FK_Client_for_contact FOREIGN KEY (Client_id) REFERENCES Client(ID));
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (1, 1, '89872346523', TO_DATE('2021.04.23', 'YYYY/MM/DD'), 'N');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (1, 1, '89372346352', TO_DATE('2021.04.22', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (1, 2, '1@mail.ru', TO_DATE('2021.04.20', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (1, 1, '89566352903', TO_DATE('2021.12.13', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (1, 1, '89376253546', TO_DATE('2021.05.30', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (2, 2, '2@mail.ru', TO_DATE('2020.02.12', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (2, 1, '89172346354', TO_DATE('2021.01.01', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (2, 1, '98276579362', TO_DATE('2021.03.03', 'YYYY/MM/DD'), 'N');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (2, 1, '89195462347', TO_DATE('2021.01.02', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (3, 2, '3@mail.ru', TO_DATE('2021.05.02', 'YYYY/MM/DD'), 'N');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (3, 2, '4@mail.ru', TO_DATE('2020.05.25', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (3, 2, '23@mail.com', TO_DATE('2021.02.06', 'YYYY/MM/DD'), 'Y');
INSERT INTO contact (client_id, c_type, c_info, created, active) VALUES (4, 1, '89276735629', TO_DATE('2021.01.02', 'YYYY/MM/DD'), 'Y');