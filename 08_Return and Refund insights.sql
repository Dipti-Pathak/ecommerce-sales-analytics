-- overall returnrate by Product category
SELECT Category, Round(sum(case when isReturned = 1 THEN 1 Else 0 end) / Count(O.orderid),2)as ReturnRate
from Orders O
join Orderdetails OD On OD.Orderid=o.orderid
Join Products P ON P.Productid= Od.Productid
Group by Category
Order By ReturnRate DESC;

-- overall Returned Rate by Region
SELECT RegionName, round(SUM(CASE when isreturned = 1 then 1 else 0 END)/Count(O.orderid),2) as R_Rate
From Orders O 
JOIN Customers C ON C.CustomerId=O.CustomerID
Join Regions R ON R.RegionID = C.RegionId
Group By RegionName
Order By R_Rate DESC;

-- Customers making frequent returns
SELECT C.Customerid, CustomerName, Count(o.OrderId) as R_count
From Orders O 
join Customers C ON C.CustomerId=O.CustomerId
where isReturned = 1
Group BY C.Customerid, CustomerName
Order By R_count DESC;