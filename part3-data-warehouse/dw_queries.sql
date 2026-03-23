-- Q1: Total sales revenue by product category for each month
SELECT 
    p.category, 
    d.month_val, 
    SUM(f.revenue) as total_revenue
FROM fact_sales f
JOIN dim_product p ON f.prod_key = p.prod_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY p.category, d.month_val;

-- Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name, 
    SUM(f.revenue) as total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT 
    d.month_val, 
    SUM(f.revenue) as monthly_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.month_val
ORDER BY d.month_val;
