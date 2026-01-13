-- General Sales Insights 
-- 1.1. What is the total revenue generated over the entire period? [Revenue - Quantity * Price ]
select sum(quantity*price) as revenue
from orderdetails od
join products p on p.ProductID=od.ProductID;

-- 1.2. Revenue Excluding Returned Orders 
select sum(od.quantity*p.price) as revenue_exclude_return
from orders o
join orderdetails od on o.OrderID=od.OrderID
join products p on p.ProductID=od.ProductID
where IsReturned=False;

-- 1.3. Total Revenue per Year / Month 
select YEAR(o.OrderDate) as years,
       Month(o.OrderDate) as months,
       sum(od.quantity*p.price) as revenue
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by years, months
order by years, months;

-- 1.4. Revenue by Product / Category 
Select ProductName, 
       Category, 
       sum(od.quantity*p.price) as revenue
from orderdetails od
join products p on p.productid = od.productid
group by ProductName, Category
order by revenue desc;

-- 1.5. What is the average order value (AOV) across all orders? 
select Avg(total_revenue)
from 
(select o.OrderID,
       sum(od.quantity*p.price) as total_revenue
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by o.OrderID) t;


-- 1.6. AOV per Year / Month 
select years, months, Avg(total_revenue)
from 
(select year(o.orderdate) years,
month(o.orderdate) months, o.OrderID,
       sum(od.quantity*p.price) as total_revenue
from orders o
join orderdetails od on od.OrderID=o.OrderID
join products p on p.ProductID=od.ProductID
group by years, months, o.OrderID) t
group by years, months
order by years, months;


-- 1.7. What is the average order size by region? 
select regionname, avg(avg_o) as Avg_order_size
from (select sum(od.quantity) as avg_o, c.regionid
from orders o
join customers c on c.CustomerID=o.CustomerID
join orderdetails od on od.OrderID=o.OrderID
group by o.orderid, c.regionid) t
join regions r on r.RegionID=t.regionid
group by RegionName
order by avg_order_size desc;