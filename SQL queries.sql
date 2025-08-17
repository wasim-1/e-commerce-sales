-- An index is created on the REGION column
CREATE INDEX idx_transactions_region ON transactions(region(20));

-- Total sales value by region.

SELECT 
    t.region, ROUND(SUM(ti.total_value), 2) AS total_sales_value
FROM
    transactions t
        JOIN
    transaction_items ti ON t.transaction_id = ti.transaction_id
GROUP BY t.region
ORDER BY total_sales_value DESC;

-- Top 5 products by total sales value (using total_value).

SELECT 
    p.product_id,
    p.product_name,
    ROUND(SUM(ti.total_value), 2) AS total_sales_value
FROM
    transaction_items ti
        JOIN
    products p ON ti.product_id = p.product_id
GROUP BY p.product_id , p.product_name
ORDER BY total_sales_value DESC
LIMIT 5;

-- Monthly sales trends (aggregate total_value by month).

SELECT 
    DATE_FORMAT(t.date, '%Y-%m') AS sales_month,
    ROUND(SUM(ti.total_value), 2) AS total_sales_value
FROM
    transactions t
        JOIN
    transaction_items ti ON t.transaction_id = ti.transaction_id
GROUP BY sales_month
ORDER BY sales_month;
