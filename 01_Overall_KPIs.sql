-- Run only after reviewing cleaning validation.
SELECT
 COUNT(*) AS sales_lines,
 COUNT(DISTINCT Transaction_ID) AS distinct_transactions,
 SUM(Quantity) AS net_units_including_returns,
 SUM(Quantity * Unit_Price) AS line_value_before_discount,
 AVG(Unit_Price) AS average_unit_price,
 SUM(Quantity * Unit_Price) / NULLIF(COUNT(DISTINCT Transaction_ID),0) AS average_transaction_value,
 COUNT(DISTINCT Customer_ID) AS identified_customers,
 COUNT(DISTINCT Product_ID) AS identified_products,
 COUNT(DISTINCT Store_ID) AS identified_stores
FROM sales_clean
WHERE Quantity IS NOT NULL AND Unit_Price IS NOT NULL;

SELECT YEAR(Order_Date) AS sales_year,
       SUM(Quantity * Unit_Price) AS line_value_before_discount,
       COUNT(DISTINCT Transaction_ID) AS transactions
FROM sales_clean
WHERE Order_Date IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
GROUP BY YEAR(Order_Date) ORDER BY sales_year;
