WITH product_metrics AS (
    SELECT
        p.ProductID,
        p.ProductName,
        COUNT(od.OrderID) AS total_orders,
        SUM(CASE WHEN o.IsReturned = 1 THEN 1 ELSE 0 END) AS returned_orders,
        SUM(od.Quantity) AS total_quantity_sold
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY p.ProductID, p.ProductName
)

SELECT
    ProductName,
    total_orders,
    returned_orders,
    ROUND(returned_orders * 100.0 / NULLIF(total_orders, 0), 2) AS return_rate_pct,
    total_quantity_sold,
    ROUND(
        (returned_orders * 1.0 / NULLIF(total_orders, 0)) * total_quantity_sold,
        2
    ) AS return_risk_index
FROM product_metrics
ORDER BY return_risk_index DESC;

-- Products with high sales volume and high return rates pose the greatest operational and revenue risk.