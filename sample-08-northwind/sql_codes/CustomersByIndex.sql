SELECT
    *
FROM
    Customers c
WHERE
    SUBSTR([CompanyName], 1, 1) = @Index
