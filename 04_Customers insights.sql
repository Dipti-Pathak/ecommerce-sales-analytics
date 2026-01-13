-- Customers insights

-- 2.1 . who are the top 10 customers by total revenue

SELECT C.CustomerID, CustomerName, SUM(OD.Quantity * P.Price) AS Total_Revenue
FROM Customers C
JOIN Orders O ON O.CustomerID=C.CustomerID
JOIN OrderDetails ON OD.Orderid=O.orderID
JOIN Products P ON P.productId=OD.Productid
GROUP BY C.Customer.ID, CustomerName
ORDER BY Total_Revenue
LIMIT 10;
-- 2.2 . What is the repeat customer rate?
select round(count(distinct case when ordercount >1 then customerid end)/count(distinct customerid),2) as repeat_customer_rate
from (
SELECT Customerid, count(orderid) as ordercount
from orders
group by customerid) as T;

-- 2.3 . what is the average time between two consecutives orders for the same customer Region-wise?
with OrderedData as (
Select c.customerid, RegionName, Orderdate, Lag(orderdate) over (partition by Customerid order by orderdate) as Prev_Orderdate
from orders O 
join Customers C on c.customerid= O.customerid
join Regions R on R.regionid=C.Regionid
group by c.customerid, RegionName, Orderdate)

select regionName, AVG(datediff(Orderdate,Prev_Orderdate)) as diff_date
from Ordereddata
group by regionName
order by diff_date;

-- 2.4. Customer Segment (based on total spend)
--      platinum if T_S > 1500
--      gold between 1500 and 1000
--      silver between 999 and 500
--      bronze <500

with Customerspend as (
SELECT O.Customerid, sum(od.quantity*p.price) As total_spend
from orders o
join orderdetails od on od.orderid=o.orderid
join products p on p.productid=od.productid
group by o.customerid)

select customername,
       case
           when total_spend > 1500 then "platinum"
           when total_spend between 1000 and 1500 then "gold"
           when total_spend between 999 and 500 then "silver"
           when total_spend < 500 then "bronze"
	   end as segment
from customerspend cs
join customers c on c.customerid=cs.customerid
order by segment;

-- 2.5. Customer lifetime value (total revenue per customer)
select c.customerid, c.Customername, Sum(od.quantity*p.price) as clv
from customers C 
join orders o on o.customerid=c.customerid
join orderdetails od on od.orderid=o.orderid
join products p on p.productid=od.productid
group by c.customerid, c.customername
order by clv DESC;


