-- Region having highest order volume
SELECT RegionName, Count(OrderID) as OrderVolume
From Orders O
JOIN Customers C On C.CustomerId=O.CustomerID
JOIN Regions R ON R.RegionId=C.RegionId
Group By RegionName
Order By OrderVolume DESC;

-- Revenue per region
Select RegionName, Sum(OD.Quantity*P.Price) as T_Revenue
From Orders O 
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN Regions R ON R.RegionID=C.RegionID
JOIN Orderdetails OD ON OD.OrderID=O.OrderID
JOIN Products P On P.ProductID=OD.ProductID
Group By Regionname
Order By T_Revenue Desc;


-- compare ordervolume vs Total Revenue by region
with Order_volume as (
SELECT RegionName, Count(OrderID) as OrderVolume
From Orders O
JOIN Customers C On C.CustomerId=O.CustomerID
JOIN Regions R ON R.RegionId=C.RegionId
Group By RegionName
Order By OrderVolume DESC),
Total_revenue as (
Select RegionName, Sum(OD.Quantity*P.Price) as T_Revenue
From Orders O 
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN Regions R ON R.RegionID=C.RegionID
JOIN Orderdetails OD ON OD.OrderID=O.OrderID
JOIN Products P On P.ProductID=OD.ProductID
Group By Regionname
Order By T_Revenue Desc)
select TR.RegionName, OrderVolume, T_Revenue
from Order_volume OV
Join total_revenue TR on TR.RegionName=OV.RegionName;