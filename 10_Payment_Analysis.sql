SELECT Payment_Method, COUNT(DISTINCT Transaction_ID) AS transactions,
       SUM(Quantity*Unit_Price) AS line_value_before_discount,
       SUM(Quantity*Unit_Price)/NULLIF(COUNT(DISTINCT Transaction_ID),0) AS average_transaction_value
FROM sales_clean
WHERE Payment_Method IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
GROUP BY Payment_Method ORDER BY line_value_before_discount DESC;
