SELECT p.Product_ID, p.Product_Name, p.Category,
       SUM(s.Quantity) AS net_units,
       SUM(s.Quantity*s.Unit_Price) AS line_value_before_discount,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost)) AS estimated_gross_profit,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost))/NULLIF(SUM(s.Quantity*s.Unit_Price),0)*100 AS estimated_margin_pct
FROM products_clean p LEFT JOIN sales_clean s ON p.Product_ID=s.Product_ID
GROUP BY p.Product_ID,p.Product_Name,p.Category
ORDER BY line_value_before_discount DESC;

SELECT p.Product_ID,p.Product_Name
FROM products_clean p LEFT JOIN sales_clean s ON p.Product_ID=s.Product_ID
GROUP BY p.Product_ID,p.Product_Name HAVING COUNT(s.Transaction_ID)=0;
