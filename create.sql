-- Create Category table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX)
);

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255),
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(255),
    Address NVARCHAR(MAX)
);

-- Create Warehouse table
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Location NVARCHAR(MAX),
    PhoneNumber NVARCHAR(20)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    SKU NVARCHAR(50) UNIQUE NOT NULL,
    CategoryID INT,
    SupplierID INT,
    CostPrice DECIMAL(10, 2),
    SellingPrice DECIMAL(10, 2),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Create Stock table
CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

-- Create StockMovement table
CREATE TABLE StockMovement (
    StockMovementID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    MovementType CHAR(3) NOT NULL CHECK (MovementType IN ('IN', 'OUT')),
    MovementQuantity INT NOT NULL,
    MovementDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    DateOfBirth DATE,
    Position NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(255),
    HireDate DATE NOT NULL
);

-- Create Delivery table
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY,
    SupplierID INT,
    EmployeeID INT,
    WarehouseID INT,
    DeliveryDate DATE NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

-- Create DeliveryProduct table
CREATE TABLE DeliveryProduct (
    DeliveryProductID INT PRIMARY KEY,
    DeliveryID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (DeliveryID) REFERENCES Delivery(DeliveryID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create BalanceSheet table
CREATE TABLE BalanceSheet (
    BalanceSheetID INT PRIMARY KEY,
    WarehouseID INT,
    ReportingDate DATE NOT NULL,
    TotalAssets DECIMAL(15, 2) NOT NULL,
    TotalLiabilities DECIMAL(15, 2) NOT NULL,
    OwnerEquity DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);
