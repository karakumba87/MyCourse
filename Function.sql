WITH
Function XXXXX(Date_from DATE, Date_to DATE) RETURN NUMBER IS n NUMBER;
    Count_day_off NUMBER := 0;
    BEGIN
        IF (Date_from IS NULL) OR (Date_to IS NULL) THEN
            RETURN 0;
        ELSE
            BEGIN
                SELECT COUNT(*)
                INTO Count_day_off
                FROM exclude
                WHERE Day_off BETWEEN Date_from AND Date_to;
                
                n := Date_to - Date_from + 1 - Count_day_off;
            END;
            RETURN n;
        END IF;
    END;
                    
SELECT XXXXX(Date_from, Date_to) AS Count_work_days
FROM Test
;


-- Таблица: Exclude
CREATE TABLE Exclude (Day_off DATE);
INSERT INTO Exclude (TO_DATE('2021/10/02', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/03', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/09', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/10', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/16', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/17', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/23', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/24', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/30', 'YYYY/MM/DD'));
INSERT INTO Exclude (TO_DATE('2021/10/31', 'YYYY/MM/DD'));


-- Таблица: Test
CREATE TABLE Test (Date_from DATE, Date_to DATE);
INSERT INTO Exclude (TO_DATE('2021/10/01', 'YYYY/MM/DD'), TO_DATE('2021/10/31', 'YYYY/MM/DD'));
