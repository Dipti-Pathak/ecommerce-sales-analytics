-- First-Time vs Repeat Buyer's total revenue
WITH customer_orders AS (
    SELECT
        o.OrderID,
        o.CustomerID,
        o.OrderDate,
        SUM(od.Quantity * p.Price) AS order_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY o.CustomerID
            ORDER BY o.OrderDate
        ) AS order_rank
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.IsReturned = 0
    GROUP BY o.OrderID, o.CustomerID, o.OrderDate
)

SELECT
    CASE
        WHEN order_rank = 1 THEN 'First-Time Buyer'
        ELSE 'Repeat Buyer'
    END AS customer_type,
    COUNT(DISTINCT OrderID) AS total_orders,
    ROUND(AVG(order_revenue), 2) AS avg_order_value,
    SUM(order_revenue) AS total_revenue
FROM customer_orders
GROUP BY customer_type;

-- Repeat buyers contribute higher AOV and a larger share of revenue compared to first-time buyers.


-- Return Rate: First-Time vs Repeat Buyers
WITH ranked_orders AS (
    SELECT
        o.OrderID,
        o.CustomerID,
        o.IsReturned,
        ROW_NUMBER() OVER (
            PARTITION BY o.CustomerID
            ORDER BY o.OrderDate
        ) AS order_rank
    FROM Orders o
)

SELECT
    CASE
        WHEN order_rank = 1 THEN 'First-Time Buyer'
        ELSE 'Repeat Buyer'
    END AS customer_type,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN IsReturned = 1 THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        SUM(CASE WHEN IsReturned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_pct
FROM ranked_orders
GROUP BY customer_type;
