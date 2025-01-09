CREATE DATABASE DETAILS;
USE DETAILS;
CREATE TABLE sales(
order_id INT PRIMARY KEY,
order_date DATE,
customer_id VARCHAR(10),
amount DECIMAL(10,2)
);

INSERT INTO sales(order_id,order_date,customer_id,amount)   VALUES
(1, '2024-01-05', 'C001', 2000.00),
(2, '2024-01-10', 'C002', 1500.00),
(3, '2024-01-15', 'C001', 3000.00),
(4, '2024-01-20', 'C003', 2500.00),
(5, '2024-02-01', 'C001', 4000.00),
(6, '2024-02-05', 'C002', 3500.00),
(7, '2024-02-10', 'C003', 3000.00),
(8, '2024-03-01', 'C001', 5000.00),
(9, '2024-03-05', 'C002', 2000.00),
(10, '2024-03-10', 'C003', 1000.00);
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m-01') AS month, -- Truncate date to the start of the month
        SUM(amount) AS total_sales,
        RANK() OVER (ORDER BY SUM(amount) DESC) AS month_rank
    FROM sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
),

cumulative_sales AS (
    SELECT 
        month,
        total_sales,
        SUM(total_sales) OVER (ORDER BY month) AS cumulative_total,
        AVG(total_sales) OVER (ORDER BY month ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_avg
    FROM monthly_sales
),

customer_sales AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_sales,
        COUNT(order_id) AS total_orders,
        RANK() OVER (ORDER BY SUM(amount) DESC) AS customer_rank,
        SUM(amount) * 100.0 / SUM(SUM(amount)) OVER () AS percentage_contribution
    FROM sales
    GROUP BY customer_id
),

detailed_sales AS (
    SELECT 
        s.customer_id,
        s.order_id,
        s.order_date,
        s.amount,
        ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS order_number,
        SUM(amount) OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS running_total,
        AVG(amount) OVER (PARTITION BY s.customer_id ORDER BY s.order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_3,
        LAG(amount) OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS previous_order,
        LEAD(amount) OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS next_order,
        FIRST_VALUE(amount) OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS first_order_amount,
        MAX(amount) OVER (PARTITION BY s.customer_id) AS max_order_amount,
        MIN(amount) OVER (PARTITION BY s.customer_id) AS min_order_amount
    FROM sales s
)

-- Final Query: Generate a comprehensive report
SELECT 
    cs.customer_id,
    cs.total_sales AS customer_total_sales,
    cs.total_orders,
    cs.customer_rank,
    cs.percentage_contribution,
    ds.order_id,
    ds.order_date,
    ds.amount AS order_amount,
    ds.order_number,
    ds.running_total,
    ds.moving_avg_3,
    ds.previous_order,
    ds.next_order,
    ds.first_order_amount,
    ds.max_order_amount,
    ds.min_order_amount,
    ms.month,
    ms.total_sales AS monthly_total_sales,
    ms.month_rank,
    cum.cumulative_total,
    cum.moving_avg
FROM 
    detailed_sales ds
LEFT JOIN customer_sales cs ON ds.customer_id = cs.customer_id
LEFT JOIN monthly_sales ms ON DATE_FORMAT(ds.order_date, '%Y-%m-01') = ms.month
LEFT JOIN cumulative_sales cum ON ms.month = cum.month
ORDER BY 
    cs.customer_id, 
    ds.order_date;
