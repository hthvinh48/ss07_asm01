SELECT 
    p.category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity)    AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;