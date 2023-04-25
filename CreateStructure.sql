CREATE DATABASE ProductData;
GO

USE ProductData;
GO

CREATE TABLE dbo.SKU
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Code AS 's' + CAST(ID AS VARCHAR(10)) UNIQUE,
    Name NVARCHAR(255)
);
GO

CREATE TABLE dbo.Family
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName NVARCHAR(255),
    BudgetValue MONEY
);
GO

CREATE TABLE dbo.Basket
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT CHECK (Quantity >= 0),
    Value MONEY CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue MONEY,
    FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID)
);
GO