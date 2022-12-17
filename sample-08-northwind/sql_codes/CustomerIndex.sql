SELECT
    DISTINCT
    SUBSTR([CompanyName], 1, 1) AS [Index]
FROM
    Customers c
