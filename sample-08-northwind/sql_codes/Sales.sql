CREATE VIEW Sales
AS
SELECT
    d.[OrderID]
    , o.[OrderDate]
    , o.[RequiredDate]
    , o.[ShippedDate]
    , STRFTIME('%Y', o.[OrderDate]) AS OrderYear
    , STRFTIME('%m', o.[OrderDate]) AS OrderMonth
    , STRFTIME('%Y', o.[ShippedDate]) AS ShippedYear
    , STRFTIME('%m', o.[ShippedDate]) AS ShippedMonth
    , CASE WHEN o.[ShippedDate] IS NULL THEN 0 ELSE 1 END AS Shipped
    , o.[ShipName]
    , o.[ShipCountry]
    , o.[ShipRegion]
    , o.[ShipAddress]
    , o.[ShipPostalCode]
    , o.Freight

    , c.CustomerID
    , c.[CompanyName] AS [CustomerCompanyName]
    , c.Country AS [CustomerCountry]
    , c.Region AS [CustomerRegion]
    , c.City AS [CustomerCity]
    , c.[Address] AS [CustomerAddress]
    , c.[PostalCode] AS [CustomerPostal Code]
    , c.[ContactTitle] AS [CustomerContactTitle]
    , c.[ContactName] AS [CustomerContactName]

    , d.[ProductID]
    , p.[ProductName]
    , p.Discontinued
    , p.[QuantityPerUnit]
    , d.[UnitPrice]

    , d.Quantity
    , ROUND(d.[UnitPrice] * d.Quantity, 2) AS [TotalSum]
    , ROUND(d.[UnitPrice] * d.Quantity * (1 - d.Discount), 2) - ROUND(d.[UnitPrice] * d.Quantity, 2) AS [DiscountSum]
    , ROUND(d.[UnitPrice] * d.Quantity * (1 - d.Discount), 2) AS [NetSum]
    , CAST(d.Discount AS money) AS Discount

    , o.[EmployeeID]
    , e.[FirstName] || ' ' || e.[LastName] AS [SalesPersonName]
    , e.[FirstName] AS [SalesPersonFirstName]
    , e.[LastName] AS [SalesPersonLastName]
    , e.Country AS [SalesPersonCountry]
    , e.Region AS [SalesPersonRegion]
    , e.City AS [SalesPersonCity]

    , p.[SupplierID]
    , s.[CompanyName] AS [SupplierCompanyName]
    , s.Country AS [SupplierCountry]
    , s.Region AS [SupplierRegion]
    , s.City AS [SupplierCity]
    , s.[ContactTitle] AS [SupplierContactTitle]
    , s.[ContactName] AS [SupplierContactName]
FROM
    [OrderDetails] d
    INNER JOIN Orders o ON o.[OrderID] = d.[OrderID]
    INNER JOIN Customers c ON c.[CustomerID] = o.[CustomerID]
    INNER JOIN Products p ON p.[ProductID] = d.[ProductID]
    LEFT OUTER JOIN Suppliers s ON s.[SupplierID] = p.[SupplierID]
    LEFT OUTER JOIN Employees e ON e.[EmployeeID] = o.[EmployeeID]
;
