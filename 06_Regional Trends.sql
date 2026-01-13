-- Monthly sales trends over the past years
SELECT YEAR(Orderdate) as 'year',
MONTH(Orderdate) as 'month',
SUM(OD.Quantity*P.Price) as Revenue
From Orders O 
Join Orderdetails OD On OD.Orderid = O.OrderId
Join Products P On P.Productid = OD.Productid
where Orderdate >= Current_date() - interval 12 month
Group By YEAR(Orderdate),MONTH(Orderdate)
Order by 'year', 'month';

-- Average order avlue change by month
SELECT DATE_FORMAT(Orderdate, "%y-%m") as Period,
round(SUM(OD.Quantity*P.Price)/count(DISTINCT O.orderId),2) as AOV
FROM Orders O 
Join Orderdetails OD ON OD.Orderid=O.Orderid
Join Products P on p.productid=OD.Productid
Group By period
Order by period;

-- Compare ordervolume vs Total Revenue by Region
-- With Order_Volume as (OrderVolume Query), T_Revenue()
-- select Order_Volume,RegionName, OrderVolume, t_revenue
-- From Order_Volume
-- Join T_Revenue TR ON TR.regionName=OV.RegionName