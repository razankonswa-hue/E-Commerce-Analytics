--1 How do revenue and the number of orders change over time (monthly/weekly)?
SELECT
    YEAR(order_date) AS Order_Year,
    MONTH(order_date) AS Order_Month,
    COUNT(DISTINCT order_id) AS Number_of_Orders,
    SUM(total_amount) AS Revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    Order_Year,
    Order_Month;
 --2 Which products generate the most revenue?
 SELECT
    p.product_id,
    p.product_name,
    SUM(oi.item_total) AS Total_Revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    Total_Revenue DESC;
--3 What is the Average Order Value (AOV), and how does it change over time?
SELECT
    AVG(total_amount) AS Average_Order_Value
FROM orders;

SELECT
    YEAR(order_date) AS Order_Year,
    MONTH(order_date) AS Order_Month,
    COUNT(DISTINCT order_id) AS Number_of_Orders,
    SUM(total_amount) AS Revenue,
    AVG(total_amount) AS Average_Order_Value
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    Order_Year,
    Order_Month;
--4 What is the average number of orders per customer?
SELECT
    AVG(Order_Count* 1.0 ) AS Average_Orders_Per_Customer
FROM
(
    SELECT
        user_id,
        COUNT(DISTINCT order_id) AS Order_Count
    FROM orders
    GROUP BY user_id
) AS Customer_Orders;
--5 Which products generate high sales but have low ratings?
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.item_total) AS Total_Revenue,
    AVG(r.rating * 1.0) AS Average_Rating
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING
    SUM(oi.item_total) > 1000
    AND AVG(r.rating * 1.0) < 3
ORDER BY
    Total_Revenue DESC;
--6 What is the average rating for each category?
SELECT
    category,
    AVG(rating * 1.0) AS Average_Rating
FROM products
GROUP BY category
ORDER BY Average_Rating DESC;
--7 Which products have the highest number of negative reviews?
SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS Negative_Reviews
FROM reviews r
JOIN products p
    ON r.product_id = p.product_id
WHERE r.rating <= 2
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    Negative_Reviews DESC;
--8 Which categories generate the highest revenue and which are the lowest-performing?
SELECT
    c.category,
    SUM(t.item_total) AS total_revenue

FROM order_items t
JOIN products c
    ON t.product_id = c.product_id
GROUP BY
    c.category
ORDER BY
    total_revenue DESC;

    



