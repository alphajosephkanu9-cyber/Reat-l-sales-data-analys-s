SELECT YEAR(Order_Date) AS sales_year, MONTH(Order_Date) AS month_number,
       DATE_FORMAT(Order_Date,'%Y-%m') AS year_month,
       SUM(Quantity*Unit_Price) AS line_value_before_discount,
       COUNT(DISTINCT Transaction_ID) AS transactions,
       SUM(Quantity) AS net_units
FROM sales_clean
WHERE Order_Date IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
GROUP BY YEAR(Order_Date), MONTH(Order_Date), DATE_FORMAT(Order_Date,'%Y-%m')
ORDER BY sales_year, month_number;

WITH monthly AS (
 SELECT DATE_FORMAT(Order_Date,'%Y-%m-01') AS month_start,
        SUM(Quantity*Unit_Price) AS revenue
 FROM sales_clean
 WHERE Order_Date IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
 GROUP BY DATE_FORMAT(Order_Date,'%Y-%m-01')
)
SELECT month_start, revenue,
       LAG(revenue) OVER (ORDER BY month_start) AS previous_month_revenue,
       revenue - LAG(revenue) OVER (ORDER BY month_start) AS mom_change,
       (revenue / NULLIF(LAG(revenue) OVER (ORDER BY month_start),0) - 1) * 100 AS mom_growth_pct
FROM monthly ORDER BY month_start;

SELECT DAYNAME(Order_Date) AS weekday, DAYOFWEEK(Order_Date) AS weekday_number,
       SUM(Quantity*Unit_Price) AS line_value
FROM sales_clean
WHERE Order_Date IS NOT NULL AND Quantity IS NOT NULL AND Unit_Price IS NOT NULL
GROUP BY DAYNAME(Order_Date), DAYOFWEEK(Order_Date)
ORDER BY weekday_number;
