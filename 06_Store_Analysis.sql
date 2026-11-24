SELECT st.Store_ID, st.Store_Name, st.City, st.Region,
       SUM(s.Quantity*s.Unit_Price) AS line_value_before_discount,
       COUNT(DISTINCT s.Transaction_ID) AS transactions,
       SUM(s.Quantity) AS net_units,
       SUM(s.Quantity*s.Unit_Price)/NULLIF(COUNT(DISTINCT s.Transaction_ID),0) AS avg_transaction_value,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost)) AS estimated_gross_profit
FROM stores_clean st
LEFT JOIN sales_clean s ON st.Store_ID=s.Store_ID
LEFT JOIN products_clean p ON s.Product_ID=p.Product_ID
GROUP BY st.Store_ID,st.Store_Name,st.City,st.Region
ORDER BY line_value_before_discount DESC;

SELECT st.Region, SUM(s.Quantity*s.Unit_Price) AS line_value_before_discount
FROM sales_clean s JOIN stores_clean st ON s.Store_ID=st.Store_ID
GROUP BY st.Region ORDER BY line_value_before_discount DESC;
