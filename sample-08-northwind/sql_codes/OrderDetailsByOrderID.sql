SELECT
    d.[OrderID]
    , d.[ProductID]
    , p.[ProductName]
    , p.[QuantityPerUnit]
    , d.[UnitPrice]
    , d.[Quantity]
    , d.[Quantity] * d.[Quantity] AS [Sum]
    , CAST(d.[Discount] AS money) AS [Discount]
FROM
    [OrderDetails] d
    INNER JOIN [Products] p ON p.[ProductID] = d.[ProductID]
WHERE
    d.[OrderID] = @OrderID
