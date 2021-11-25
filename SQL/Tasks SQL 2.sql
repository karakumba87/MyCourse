----------------
-- Задание №1
----------------
SELECT Name, COUNT(Id_order) OVER(PARTITION BY Id_customer)
FROM Customer INNER JOIN Order ON Customer.Id_customer = Order.Id_customer;

----------------
-- Задание №2
----------------
SELECT Customer.Name, Goods.Name
FROM Customer INNER JOIN Order ON Customer.Id_customer = Order.Id_customer
				INNER JOIN Goods ON Order.Id_goods = Goods.Id_goods;

----------------
-- Задание №3
----------------
SELECT Goods.Name				
FROM Goods INNER JOIN (
				SELECT AVG(Price) OVER(PARTITION BY Name) AS Avg_price, Name
				FROM  Goods
				) AS Avg_price_table ON Goods.Name = Avg_price_table.Name
WHERE Price <= Avg_price;

----------------
-- Задание №4
-- Вроде оба запроса работают,
-- но не определюсь какой лучше
----------------
SELECT qw."Month" AS "Месяц", dep.name AS "Отдел", qw."Count_p" AS "Количество родившихся", qw."Order"
FROM    (
            SELECT TO_CHAR(birhdate, 'Month') AS "Month", dep_id_fk
                , COUNT(Id) OVER(PARTITION BY dep_id_fk, EXTRACT(MONTH FROM birhdate)) AS "Count_p"
                , EXTRACT(MONTH FROM birhdate) AS "Order"
            FROM    Emp
        ) qw INNER JOIN Dep ON qw.Dep_id_fk = Dep.Id
GROUP BY qw."Month", dep.name, qw."Count_p", qw."Order"
ORDER BY qw."Order"
;

SELECT Name_month AS "Месяц", Dep.Name AS "Отдел", Count_people AS "Количество родившихся"
FROM    (
        SELECT TO_CHAR(birhdate, 'Month') AS Name_month, Dep_id_fk AS Dep_id
            , COUNT(id) AS Count_people, EXTRACT(MONTH FROM birhdate) AS Rang_month
        FROM Emp
        GROUP BY dep_id_fk, TO_CHAR(birhdate, 'Month'), EXTRACT(MONTH FROM birhdate)
        ) Temp_table INNER JOIN Dep ON Temp_table.Dep_id = Dep.Id
ORDER BY Rang_month
;
------------------------------------------------------------

----------------
-- Задание №5
----------------
WITH Cte AS (
            SELECT Temp_table."Year" AS Year_group, Temp_table."Month" AS Month_group
                , Dep.name AS Department_group, Temp_table."Count_p" AS Count_group
                , Temp_table."Order" AS For_sort
            FROM    (
                    SELECT TO_CHAR(birhdate, 'YYYY') AS "Year"
                        , TO_CHAR(birhdate, 'Month') AS "Month"
                        , Dep_id_fk
                        , COUNT(Id) OVER(PARTITION BY Dep_id_fk, EXTRACT(MONTH FROM birhdate), TO_CHAR(birhdate, 'YYYY')) AS "Count_p"
                        , DENSE_RANK() OVER(ORDER BY EXTRACT(YEAR FROM birhdate), EXTRACT(MONTH FROM birhdate)) AS "Order"
                    FROM    Emp
                ) Temp_table INNER JOIN Dep ON Temp_table.Dep_id_fk = Dep.Id
            GROUP BY Temp_table."Year", Temp_table."Month", Dep.name, Temp_table."Count_p", Temp_table."Order"
            )
            
SELECT Cte.Year_group AS "Год", Cte.Month_group AS "Месяц", Cte.Department_group AS "Отдел"
    , Cte.Count_group AS "Количество родившихся"
    , Count_group - LAG(Cte.Count_group) OVER(PARTITION BY Cte.Department_group, Cte.Month_group ORDER BY Cte.Year_group) AS "Дельта"
FROM Cte
ORDER BY Cte.For_sort
;