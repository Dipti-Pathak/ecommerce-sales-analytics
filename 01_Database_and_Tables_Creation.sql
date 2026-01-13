-- Creating Database
Create Database ecommerce;
use ecommerce;

-- 1. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    RegionID INT,
    CreatedAt DATE,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- 2. Regions Table
CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100),
    Country VARCHAR(100)
);

-- 3. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- 4. Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    IsReturned BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 5. OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
