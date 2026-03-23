-- Finding total sales for Electronics by City in 2023
SELECT 
    s.city, 
    SUM(f.revenue) AS total_money
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
JOIN dim_product p ON f.prod_key = p.prod_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE p.category = 'Electronics' 
  AND d.year_val = 2023
GROUP BY s.city
ORDER BY total_money DESC;
