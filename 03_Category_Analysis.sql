SELECT p.Category, SUM(s.Quantity) AS net_units,
       SUM(s.Quantity*s.Unit_Price) AS line_value_before_discount,
       COUNT(DISTINCT s.Transaction_ID) AS transactions,
       SUM(s.Quantity*s.Unit_Price) / NULLIF(SUM(SUM(s.Quantity*s.Unit_Price)) OVER (),0)*100 AS value_share_pct,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost)) AS estimated_gross_profit
FROM sales_clean s JOIN products_clean p ON s.Product_ID=p.Product_ID
WHERE s.Quantity IS NOT NULL AND s.Unit_Price IS NOT NULL
GROUP BY p.Category ORDER BY line_value_before_discount DESC;
