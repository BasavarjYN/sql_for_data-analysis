-- ===========================================
-- TASK 3: SQL DATA ANALYSIS QUERIES
-- ===========================================

-- QUERY 1: BASIC SELECT WITH WHERE AND ORDER BY
-- Get all electronics products sorted by price
SELECT * FROM products 
WHERE category = 'Electronics' 
ORDER BY price DESC;

-- QUERY 2: GROUP BY WITH HAVING CLAUSE
-- Find customers with more than 1 order
SELECT customer_id, COUNT(*) as order_count 
FROM orders 
GROUP BY customer_id 
HAVING COUNT(*) > 1;

-- QUERY 3: INNER JOIN
-- Show customer names with their order details
SELECT 
    c.customer_id,
    c.name as customer_name,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- QUERY 4: LEFT JOIN
-- Show all customers and their orders (even if they have no orders)
SELECT 
    c.name as customer_name,
    COUNT(o.order_id) as total_orders,
    COALESCE(SUM(o.total_amount), 0) as total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- QUERY 5: SUBQUERY
-- Find customers who spent more than average order value
SELECT name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id 
    FROM orders 
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);

-- QUERY 6: AGGREGATE FUNCTIONS (SUM, AVG)
-- Calculate average revenue per user (ARPU)
SELECT 
    COUNT(DISTINCT customer_id) as total_customers,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_order_value,
    SUM(total_amount) / COUNT(DISTINCT customer_id) as avg_revenue_per_user
FROM orders;

-- QUERY 7: CREATE A VIEW
-- Create a view for customer order summary
CREATE VIEW IF NOT EXISTS customer_order_summary AS
SELECT 
    c.customer_id,
    c.name,
    c.email,
    COUNT(o.order_id) as total_orders,
    COALESCE(SUM(o.total_amount), 0) as total_spent,
    COALESCE(AVG(o.total_amount), 0) as avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email;

-- QUERY 8: QUERY THE VIEW
-- Use the view we just created
SELECT * FROM customer_order_summary;

-- QUERY 9: HANDLE NULL VALUES
-- Show customers with email handling NULL values
SELECT 
    name,
    COALESCE(email, 'No email provided') as email_address,
    join_date
FROM customers;

-- QUERY 10: MULTIPLE JOINS
-- Detailed order report with product information
SELECT 
    o.order_id,
    c.name as customer_name,
    p.product_name,
    oi.quantity,
    oi.price as unit_price,
    (oi.quantity * oi.price) as line_total,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- QUERY 11: CATEGORY ANALYSIS
-- Sales analysis by product category
SELECT 
    p.category,
    COUNT(oi.order_item_id) as items_sold,
    SUM(oi.quantity * oi.price) as total_revenue,
    AVG(oi.price) as avg_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- QUERY 12: DIFFERENCE BETWEEN WHERE AND HAVING DEMO
-- WHERE filters before grouping, HAVING filters after grouping
SELECT customer_id, COUNT(*) as order_count
FROM orders
WHERE total_amount > 50  -- Filters individual orders before grouping
GROUP BY customer_id
HAVING COUNT(*) >= 1;    -- Filters groups after grouping

-- QUERY 13: RIGHT JOIN EXAMPLE (Less common but included for completeness)
SELECT 
    p.product_name,
    COUNT(oi.order_item_id) as times_ordered
FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

-- QUERY 14: WINDOW FUNCTION (Advanced - Bonus)
-- Show each order with customer's total spending
SELECT 
    o.order_id,
    c.name,
    o.total_amount,
    SUM(o.total_amount) OVER (PARTITION BY o.customer_id) as customer_lifetime_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- QUERY 15: SELF JOIN (Advanced - Bonus)
-- Find customers who joined in the same month
SELECT 
    c1.name as customer1,
    c2.name as customer2,
    strftime('%Y-%m', c1.join_date) as join_month
FROM customers c1
JOIN customers c2 ON strftime('%Y-%m', c1.join_date) = strftime('%Y-%m', c2.join_date)
WHERE c1.customer_id < c2.customer_id;