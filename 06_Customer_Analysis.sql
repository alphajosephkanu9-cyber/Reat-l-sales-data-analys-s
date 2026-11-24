-- Customer-level purchasing behavior
WITH customer_activity AS (
 SELECT Customer_ID, COUNT(DISTINCT Transaction_ID) AS transactions,
        SUM(Quantity) AS net_units, SUM(Quantity*Unit_Price) AS line_value
 FROM sales_clean
 WHERE Customer_ID IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
 GROUP BY Customer_ID
)
SELECT COUNT(*) AS purchasing_customers,
       SUM(transactions=1) AS one_time_customers,
       SUM(transactions>1) AS repeat_customers,
       SUM(line_value)/NULLIF(COUNT(*),0) AS revenue_per_customer
FROM customer_activity;

-- Top customers and purchasing frequency (separate CTE because CTE scope is one statement)
WITH customer_activity AS (
 SELECT Customer_ID, COUNT(DISTINCT Transaction_ID) AS transactions,
        SUM(Quantity) AS net_units, SUM(Quantity*Unit_Price) AS line_value
 FROM sales_clean
 WHERE Customer_ID IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
 GROUP BY Customer_ID
)
SELECT c.Customer_ID,c.Customer_Name,c.City,a.transactions,a.net_units,a.line_value
FROM customer_activity a LEFT JOIN customers_clean c ON a.Customer_ID=c.Customer_ID
ORDER BY a.line_value DESC;

WITH customer_activity AS (
 SELECT Customer_ID, SUM(Quantity*Unit_Price) AS line_value
 FROM sales_clean
 WHERE Customer_ID IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
 GROUP BY Customer_ID
)
SELECT c.City, SUM(a.line_value) AS line_value
FROM customer_activity a LEFT JOIN customers_clean c ON a.Customer_ID=c.Customer_ID
GROUP BY c.City ORDER BY line_value DESC;
