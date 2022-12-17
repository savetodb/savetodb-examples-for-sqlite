SELECT
    row_number() OVER (ORDER BY p.section, p.item, p.company) AS sort_order
    , p.section
    , MAX(p.level) AS level
    , p.item
    , p.company
    , CASE WHEN p.company IS NOT NULL THEN ' ' || MAX(p.name) ELSE MAX(p.name) END AS Name
    , SUM(p.total) AS Total
    , SUM(p.Jan) AS Jan
    , SUM(p.Feb) AS Feb
    , SUM(p.Mar) AS Mar
    , SUM(p.Apr) AS Apr
    , SUM(p.May) AS May
    , SUM(p.Jun) AS Jun
    , SUM(p.Jul) AS Jul
    , SUM(p.Aug) AS Aug
    , SUM(p.Sep) AS Sep
    , SUM(p.Oct) AS Oct
    , SUM(p.Nov) AS Nov
    , SUM(p.[Dec]) AS [Dec]
FROM
    (
    -- Companies
    SELECT
        p.section
        , 2 AS level
        , p.item
        , p.company
        , p.company AS name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , p.item
            , p.company
            , strftime('%m', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
        WHERE
            p.company IS NOT NULL
            AND strftime('%Y', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section,
        p.item,
        p.company,
        p.period

    UNION ALL
    SELECT
        p.section
        , 1 AS level
        , p.item
        , NULL AS company
        , p.item AS name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , p.item
            , strftime('%m', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
        WHERE
            p.item IS NOT NULL
            AND strftime('%Y', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section,
        p.item,
        p.period

    UNION ALL
    SELECT
        p.section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , p.item_type AS name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , CAST(CASE WHEN p.credit IS NOT NULL THEN 'Total Expenses' ELSE 'Total Income' END AS NVARCHAR(50)) AS item_type
            , strftime('%m', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
        WHERE
            strftime('%Y', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section,
        p.period

    UNION ALL
    SELECT
        4 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Net Change' AS name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            strftime('%m', p.[date]) AS period
            , COALESCE(p.debit, 0) - COALESCE(p.credit, 0) AS amount
        FROM
            cashbook p
        WHERE
            strftime('%Y', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.period

    UNION ALL
    SELECT
        1 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Opening Balance' AS name
        , p.period
        , NULL AS total
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            strftime('%m', d.[date]) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            cashbook p
            CROSS JOIN (
                SELECT date(@Year || '-01-01') AS [date]
                UNION SELECT date(@Year || '-02-01') AS [date]
                UNION SELECT date(@Year || '-03-01') AS [date]
                UNION SELECT date(@Year || '-04-01') AS [date]
                UNION SELECT date(@Year || '-05-01') AS [date]
                UNION SELECT date(@Year || '-06-01') AS [date]
                UNION SELECT date(@Year || '-07-01') AS [date]
                UNION SELECT date(@Year || '-08-01') AS [date]
                UNION SELECT date(@Year || '-09-01') AS [date]
                UNION SELECT date(@Year || '-10-01') AS [date]
                UNION SELECT date(@Year || '-11-01') AS [date]
                UNION SELECT date(@Year || '-12-01') AS [date]
            ) d
        WHERE
            p.[date] < d.[date]
        GROUP BY
            d.[date]
        ) p
    GROUP BY
        p.period

    UNION ALL
    SELECT
        5 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Closing Balance' AS name
        , p.period
        , NULL AS total
        , CASE p.period WHEN '02' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN '03' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN '04' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN '05' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN '06' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN '07' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN '08' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN '09' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN '10' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN '11' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN '12' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN '01' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            strftime('%m', d.[date]) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            cashbook p
            CROSS JOIN (
                SELECT date(@Year || '-02-01') AS [date]
                UNION SELECT date(@Year || '-03-01') AS [date]
                UNION SELECT date(@Year || '-04-01') AS [date]
                UNION SELECT date(@Year || '-05-01') AS [date]
                UNION SELECT date(@Year || '-06-01') AS [date]
                UNION SELECT date(@Year || '-07-01') AS [date]
                UNION SELECT date(@Year || '-08-01') AS [date]
                UNION SELECT date(@Year || '-09-01') AS [date]
                UNION SELECT date(@Year || '-10-01') AS [date]
                UNION SELECT date(@Year || '-11-01') AS [date]
                UNION SELECT date(@Year || '-12-01') AS [date]
                UNION SELECT date(@Year || '-12-01', '+1 month') AS [date]
            ) d
        WHERE
            p.[date] < d.[date]
        GROUP BY
            d.[date]
        ) p
    GROUP BY
        p.period
    ) p
GROUP BY
    p.section,
    p.item,
    p.company
ORDER BY
    sort_order
