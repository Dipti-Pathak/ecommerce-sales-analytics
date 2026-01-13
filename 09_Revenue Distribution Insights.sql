-- Revenue Contribution of Top Customers
WITH customer_revenue AS (
SELECT o.CustomerID,
        SUM(od.Quantity * p.Price) AS total_revenue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.IsReturned = 0
    GROUP BY o.CustomerID
  ) ,
ranked_customers AS (
SELECT
        CustomerID,
        total_revenue,
        SUM(total_revenue) OVER () AS overall_revenue,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
        ) AS cumulative_revenue
    FROM customer_revenue)
SELECT
    CustomerID,
    total_revenue,
    ROUND(cumulative_revenue / overall_revenue * 100, 2) AS cumulative_revenue_pct
FROM ranked_customers
ORDER BY total_revenue DESC;


-- Revenue Contribution of Top Products
SELECT
    p.ProductName,
    SUM(od.Quantity * p.Price) AS product_revenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.IsReturned = 0
GROUP BY p.ProductName
ORDER BY product_revenue DESC
LIMIT 10;
