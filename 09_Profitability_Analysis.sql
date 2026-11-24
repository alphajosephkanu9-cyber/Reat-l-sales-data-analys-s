SELECT
 SUM(s.Quantity*s.Unit_Price) AS line_value,
 SUM(s.Quantity*p.Unit_Cost) AS estimated_cost,
 SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost)) AS estimated_gross_profit,
 SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost))/NULLIF(SUM(s.Quantity*s.Unit_Price),0)*100 AS estimated_gross_margin_pct
FROM sales_clean s JOIN products_clean p ON s.Product_ID=p.Product_ID
WHERE s.Quantity IS NOT NULL AND s.Unit_Price IS NOT NULL AND p.Unit_Cost IS NOT NULL;

SELECT p.Category,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost)) AS estimated_gross_profit,
       SUM(s.Quantity*s.Unit_Price) AS line_value,
       SUM(s.Quantity*(s.Unit_Price-p.Unit_Cost))/NULLIF(SUM(s.Quantity*s.Unit_Price),0)*100 AS estimated_margin_pct
FROM sales_clean s JOIN products_clean p ON s.Product_ID=p.Product_ID
WHERE s.Quantity IS NOT NULL AND s.Unit_Price IS NOT NULL AND p.Unit_Cost IS NOT NULL
GROUP BY p.Category ORDER BY estimated_gross_profit DESC;
