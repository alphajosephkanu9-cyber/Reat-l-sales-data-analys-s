SELECT Discount, COUNT(*) AS sales_lines, SUM(Quantity) AS net_units,
       SUM(Quantity*Unit_Price) AS line_value_before_discount
FROM sales_clean
GROUP BY Discount ORDER BY Discount;

SELECT
 SUM(Discount=0) AS no_discount_lines,
 SUM(Discount>0 AND Discount<=0.10) AS low_discount_lines,
 SUM(Discount>0.10 AND Discount<=0.20) AS medium_discount_lines,
 SUM(Discount>0.20) AS high_discount_lines
FROM sales_clean WHERE Discount IS NOT NULL;
