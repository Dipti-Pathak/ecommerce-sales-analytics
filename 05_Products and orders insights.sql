-- 3.1. top 10 most sold products (by quantity)
select p.productid, productname, sum(od.quantity) as totalqty
from orderdetails od
join products p on p.productid=od.productid
group by p.productid, productname
order by totalqty desc
limit 10;

-- 3.2. top 10 most sold products (by revenue)
select p.productid, productname, sum(od.quantity*p.price) as total_revenue
from orderdetails od
join products p on p.productid=od.productid
group by p.productid, productname
order by total_revenue desc
limit 10;

-- 3.3. product having highest return rate (return rate = returned quantity/total quantity)
with SOLD as (select productid, sum(quantity) as t_qty
from orderdetails
group by productid) , 

RETURNED as (select productid, sum(quantity) as R_qty
from orderdetails od
join orders o on o.orderid= od.orderid
where isreturned = 1
group by productid)

select s.productid, round((R_qty/t_qty),2) as Returned_rate
from products p
join SOLD S ON S.productid=p.productid
join RETURNED R on R.productid=P.productid
order by Returned_rate desc
limit 10;

-- 3.4. return_rate by category
with SOLD as (select category, sum(quantity) as t_qty
from orderdetails od
join products p on p.productid=od.productid
group by Category) , 

RETURNED as (select Category, sum(quantity) as R_qty
from orderdetails od
join orders o on o.orderid= od.orderid
join products p on p.productid= od.productid
where isreturned = 1
group by Category)

select s.Category, round((R_qty/t_qty),2) as Returned_rate
from sold s
join RETURNED R on R.Category=S.Category
order by Returned_rate desc
limit 10;

-- 3.5. average price of products per region
SELECT RegionName, ROUND(SUM(OD.Quantity*P.Price)/SUM(OD.Quantity),2) As AvgP
From Orders O 
join Customers C on C.CustomerId=O.CustomerId
join Regions R ON R.RegionId=C.RegionId
Join orderdetails Od ON OD.OrderId=O.OrderId
Join Products P ON P.ProductId= OD.ProductId
Group by RegionName
Order By AvgP DESC;

-- 3.6. sales trend for each product category
SELECT DATE_FORMAT(Orderdate, "%Y-%M") as Period, Category, SUM(OD.Quantity*P.Price) as Revenue 
From Orders O 
Join Orderdetails OD ON OD.Orderid=O.OrderId
Join Products P ON P.ProductId=OD.ProductId
Group by Period, Category
Order By Period, Category, Revenue DESC;