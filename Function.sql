WITH
Function XXXXX(Date_from DATE, Date_to DATE) RETURN NUMBER IS n NUMBER;
    BEGIN
        IF (Date_from IS NULL) OR (Date_to IS NULL) THEN
            RETURN 0;
        ELSE
            BEGIN
                SELECT COUNT(*)
                INTO n
                FROM (  SELECT ROWNUM AS Rnum
                        FROM All_objects
                        WHERE ROWNUM <= Date_to - Date_from + 1)
                WHERE Date_from + Rnum - 1 NOT IN (
                                        SELECT DayOff
                                        FROM Exclude
                                        );
            RETURN n;
            END;
        END IF;
    END;
                    
SELECT XXXXX(Date_from, Date_to)
FROM Test
;