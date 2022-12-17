-- =============================================
-- Application: Sample 02 - Advanced SaveToDB Features
-- Version 10.6, December 13, 2022
--
-- Copyright 2017-2022 Gartle LLC
--
-- License: MIT
--
-- Prerequisites: SaveToDB Framework 10.0 or higher
-- =============================================

CREATE TABLE accounts (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name nvarchar(50) NOT NULL,
    CONSTRAINT IX_accounts_name UNIQUE (name)
);

CREATE TABLE companies (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name nvarchar(50) NOT NULL
);

CREATE INDEX IX_companies_name ON companies (name);

CREATE TABLE items (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name nvarchar(50) NOT NULL,
    CONSTRAINT IX_items_name UNIQUE (name)
);

CREATE TABLE item_companies (
    item_id integer,
    company_id integer,
    CONSTRAINT PK_item_companies PRIMARY KEY (item_id, company_id)
    FOREIGN KEY (company_id) REFERENCES companies (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (item_id) REFERENCES items (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE cashbook (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    date datetime NOT NULL,
    account_id integer NOT NULL,
    item_id integer NULL,
    company_id integer NULL,
    debit money NULL,
    credit money NULL,
    checked boolean NULL,
    FOREIGN KEY (account_id) REFERENCES accounts (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (company_id) REFERENCES companies (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (item_id) REFERENCES items (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE VIEW view_cashbook
AS
SELECT
    p.id
    , p.date
    , p.account_id
    , p.item_id
    , p.company_id
    , p.debit
    , p.credit
FROM
    cashbook p
;

CREATE VIEW view_cashbook2
AS
SELECT
    *
FROM
    cashbook p
;

CREATE VIEW view_cashbook3
AS
SELECT
    *
FROM
    cashbook p
;

CREATE VIEW xl_actions_online_help
AS
SELECT
    CAST(NULL AS nvarchar) AS TABLE_SCHEMA
    , t.name AS TABLE_NAME
    , CAST(NULL AS nvarchar) AS COLUMN_NAME
    , 'Actions' AS EVENT_NAME
    , CAST(NULL AS nvarchar) AS HANDLER_SCHEMA
    , 'See Online Help' AS HANDLER_NAME
    , 'HTTP' AS HANDLER_TYPE
    , 'https://www.savetodb.com/samples/sample02-' || t.name AS HANDLER_CODE
    , CAST(NULL AS nvarchar) AS TARGET_WORKSHEET
    , 1 AS MENU_ORDER
    , 0 AS EDIT_PARAMETERS
FROM
    sqlite_master t
WHERE
    t.type IN ('table', 'view')
    AND t.name NOT LIKE 'sqlite%'
    AND NOT t.name LIKE 'xl_%'
;

INSERT INTO accounts (id, name) VALUES (1, 'Bank');

INSERT INTO items (id, name) VALUES (1, 'Revenue');
INSERT INTO items (id, name) VALUES (2, 'Expenses');
INSERT INTO items (id, name) VALUES (3, 'Payroll');
INSERT INTO items (id, name) VALUES (4, 'Taxes');

INSERT INTO companies (id, name) VALUES (1, 'Customer C1');
INSERT INTO companies (id, name) VALUES (2, 'Customer C2');
INSERT INTO companies (id, name) VALUES (3, 'Customer C3');
INSERT INTO companies (id, name) VALUES (4, 'Customer C4');
INSERT INTO companies (id, name) VALUES (5, 'Customer C5');
INSERT INTO companies (id, name) VALUES (6, 'Customer C6');
INSERT INTO companies (id, name) VALUES (7, 'Customer C7');
INSERT INTO companies (id, name) VALUES (8, 'Supplier S1');
INSERT INTO companies (id, name) VALUES (9, 'Supplier S2');
INSERT INTO companies (id, name) VALUES (10, 'Supplier S3');
INSERT INTO companies (id, name) VALUES (11, 'Supplier S4');
INSERT INTO companies (id, name) VALUES (12, 'Supplier S5');
INSERT INTO companies (id, name) VALUES (13, 'Supplier S6');
INSERT INTO companies (id, name) VALUES (14, 'Supplier S7');
INSERT INTO companies (id, name) VALUES (15, 'Corporate Income Tax');
INSERT INTO companies (id, name) VALUES (16, 'Individual Income Tax');
INSERT INTO companies (id, name) VALUES (17, 'Payroll Taxes');

INSERT INTO item_companies (item_id, company_id) VALUES (1, 1);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 2);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 3);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 4);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 5);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 6);
INSERT INTO item_companies (item_id, company_id) VALUES (1, 7);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 8);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 9);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 10);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 11);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 12);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 13);
INSERT INTO item_companies (item_id, company_id) VALUES (2, 14);
INSERT INTO item_companies (item_id, company_id) VALUES (4, 15);
INSERT INTO item_companies (item_id, company_id) VALUES (4, 16);
INSERT INTO item_companies (item_id, company_id) VALUES (4, 17);

INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-01-10', 1, 1, 1, 200000, NULL, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-01-10', 1, 2, 8, NULL, 50000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-01-31', 1, 3, NULL, NULL, 85000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-01-31', 1, 4, 16, NULL, 15000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-01-31', 1, 4, 17, NULL, 15000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-10', 1, 1, 1, 300000, NULL, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-10', 1, 1, 2, 100000, NULL, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-10', 1, 2, 9, NULL, 50000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-10', 1, 2, 8, NULL, 100000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-28', 1, 3, NULL, NULL, 85000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-28', 1, 4, 16, NULL, 15000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-02-28', 1, 4, 17, NULL, 15000, 1);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-10', 1, 1, 1, 300000, NULL, 0);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-10', 1, 1, 2, 200000, NULL, 0);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-10', 1, 1, 3, 100000, NULL, 0);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-15', 1, 4, 15, NULL, 100000, NULL);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-31', 1, 3, NULL, NULL, 170000, NULL);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-31', 1, 4, 16, NULL, 30000, NULL);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-31', 1, 4, 17, NULL, 30000, NULL);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-31', 1, 2, 9, NULL, 50000, NULL);
INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES ('2022-03-31', 1, 2, 8, NULL, 100000, NULL);

INSERT INTO objects (TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, TABLE_CODE, INSERT_OBJECT, UPDATE_OBJECT, DELETE_OBJECT) VALUES (NULL, 'usp_cash_by_months', 'CODE', 'SELECT
    row_number() OVER (ORDER BY p.section, p.item_id, p.company_id) AS sort_order
    , p.section
    , MAX(p.level) AS level
    , p.item_id
    , p.company_id
    , CASE WHEN p.company_id IS NOT NULL THEN '' '' || MAX(COALESCE(t1.TRANSLATED_NAME, p.name)) ELSE MAX(COALESCE(t1.TRANSLATED_NAME, p.name)) END AS Name
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
    SELECT
        p.section
        , 2 AS level
        , p.item_id
        , p.company_id
        , p.name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , p.item_id
            , p.company_id
            , c.name
            , strftime(''%m'', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
            LEFT OUTER JOIN items i ON i.id = p.item_id
            LEFT OUTER JOIN companies c ON c.id = p.company_id
        WHERE
            p.company_id IS NOT NULL
            AND strftime(''%Y'', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section
        , p.item_id
        , p.company_id
        , p.period

    UNION ALL
    SELECT
        p.section
        , 1 AS level
        , p.item_id
        , NULL AS company_id
        , p.name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , p.item_id
            , i.name
            , strftime(''%m'', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
            LEFT OUTER JOIN items i ON i.id = p.item_id
        WHERE
            p.item_id IS NOT NULL
            AND strftime(''%Y'', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section
        , p.item_id
        , p.period

    UNION ALL
    SELECT
        p.section
        , 0 AS level
        , NULL AS item_id
        , NULL AS company_id
        , p.name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS integer) AS section
            , CAST(CASE WHEN p.credit IS NOT NULL THEN ''Total Expenses'' ELSE ''Total Income'' END AS varchar) AS name
            , strftime(''%m'', p.[date]) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            cashbook p
        WHERE
            strftime(''%Y'', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.section
        , p.period

    UNION ALL
    SELECT
        4 AS section
        , 0 AS level
        , NULL AS item_id
        , NULL AS company_id
        , ''Net Change'' AS name
        , p.period
        , SUM(p.amount) AS total
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE NULL END AS Jan
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE NULL END AS Feb
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE NULL END AS Mar
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE NULL END AS Apr
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE NULL END AS May
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE NULL END AS Jun
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE NULL END AS Jul
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE NULL END AS Aug
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE NULL END AS Sep
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE NULL END AS Oct
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE NULL END AS Nov
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE NULL END AS [Dec]
    FROM
        (
        SELECT
            strftime(''%m'', p.[date]) AS period
            , COALESCE(p.debit, 0) - COALESCE(p.credit, 0) AS amount
        FROM
            cashbook p
        WHERE
            strftime(''%Y'', p.[date]) = CAST(@Year AS varchar)
        ) p
    GROUP BY
        p.period

    UNION ALL
    SELECT
        1 AS section
        , 0 AS level
        , NULL AS item_id
        , NULL AS company_id
        , ''Opening Balance'' AS name
        , p.period
        , 0 AS total
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE 0 END AS Jan
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE 0 END AS Feb
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE 0 END AS Mar
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE 0 END AS Apr
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE 0 END AS May
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE 0 END AS Jun
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE 0 END AS Jul
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE 0 END AS Aug
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE 0 END AS Sep
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE 0 END AS Oct
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE 0 END AS Nov
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE 0 END AS [Dec]
    FROM
        (
        SELECT
            strftime(''%m'', d.[date]) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            cashbook p
            CROSS JOIN (
                SELECT date(@Year || ''-01-01'') AS [date]
                UNION SELECT date(@Year || ''-02-01'') AS [date]
                UNION SELECT date(@Year || ''-03-01'') AS [date]
                UNION SELECT date(@Year || ''-04-01'') AS [date]
                UNION SELECT date(@Year || ''-05-01'') AS [date]
                UNION SELECT date(@Year || ''-06-01'') AS [date]
                UNION SELECT date(@Year || ''-07-01'') AS [date]
                UNION SELECT date(@Year || ''-08-01'') AS [date]
                UNION SELECT date(@Year || ''-09-01'') AS [date]
                UNION SELECT date(@Year || ''-10-01'') AS [date]
                UNION SELECT date(@Year || ''-11-01'') AS [date]
                UNION SELECT date(@Year || ''-12-01'') AS [date]
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
        , NULL AS item_id
        , NULL AS company_id
        , ''Closing Balance'' AS name
        , p.period
        , 0 AS total
        , CASE p.period WHEN ''02'' THEN SUM(p.amount) ELSE 0 END AS Jan
        , CASE p.period WHEN ''03'' THEN SUM(p.amount) ELSE 0 END AS Feb
        , CASE p.period WHEN ''04'' THEN SUM(p.amount) ELSE 0 END AS Mar
        , CASE p.period WHEN ''05'' THEN SUM(p.amount) ELSE 0 END AS Apr
        , CASE p.period WHEN ''06'' THEN SUM(p.amount) ELSE 0 END AS May
        , CASE p.period WHEN ''07'' THEN SUM(p.amount) ELSE 0 END AS Jun
        , CASE p.period WHEN ''08'' THEN SUM(p.amount) ELSE 0 END AS Jul
        , CASE p.period WHEN ''09'' THEN SUM(p.amount) ELSE 0 END AS Aug
        , CASE p.period WHEN ''10'' THEN SUM(p.amount) ELSE 0 END AS Sep
        , CASE p.period WHEN ''11'' THEN SUM(p.amount) ELSE 0 END AS Oct
        , CASE p.period WHEN ''12'' THEN SUM(p.amount) ELSE 0 END AS Nov
        , CASE p.period WHEN ''01'' THEN SUM(p.amount) ELSE 0 END AS [Dec]
    FROM
        (
        SELECT
            strftime(''%m'', d.[date]) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            cashbook p
            CROSS JOIN (
                SELECT date(@Year || ''-02-01'') AS [date]
                UNION SELECT date(@Year || ''-03-01'') AS [date]
                UNION SELECT date(@Year || ''-04-01'') AS [date]
                UNION SELECT date(@Year || ''-05-01'') AS [date]
                UNION SELECT date(@Year || ''-06-01'') AS [date]
                UNION SELECT date(@Year || ''-07-01'') AS [date]
                UNION SELECT date(@Year || ''-08-01'') AS [date]
                UNION SELECT date(@Year || ''-09-01'') AS [date]
                UNION SELECT date(@Year || ''-10-01'') AS [date]
                UNION SELECT date(@Year || ''-11-01'') AS [date]
                UNION SELECT date(@Year || ''-12-01'') AS [date]
                UNION SELECT date(@Year || ''-12-01'', ''+1 month'') AS [date]
            ) d
        WHERE
            p.[date] < d.[date]
        GROUP BY
            d.[date]
        ) p
    GROUP BY
        p.period
    ) p
    LEFT OUTER JOIN translations t1 ON t1.TABLE_NAME = ''strings'' AND t1.COLUMN_NAME = p.name AND t1.LANGUAGE_NAME = @data_language
GROUP BY
    p.section
    , p.item_id
    , p.company_id
ORDER BY
    sort_order
', NULL, NULL, NULL);

INSERT INTO objects (TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, TABLE_CODE, INSERT_OBJECT, UPDATE_OBJECT, DELETE_OBJECT) VALUES (NULL, 'code_cashbook', 'CODE', 'SELECT
    t.id
    , t.date
    , t.account_id
    , t.item_id
    , t.company_id
    , t.debit
    , t.credit
    , t.checked
FROM
    cashbook t
WHERE
    COALESCE(@account_id, t.account_id, -1) = COALESCE(t.account_id, -1)
    AND COALESCE(@item_id, t.item_id, -1) = COALESCE(t.item_id, -1)
    AND COALESCE(@company_id, t.company_id, -1) = COALESCE(t.company_id, -1)
    AND t.date BETWEEN COALESCE(@start_date, ''2020-01-01'') AND COALESCE(@end_date, ''2049-01-01'')
    AND (@checked IS NULL OR t.checked = @checked)', 'INSERT INTO cashbook (date, account_id, item_id, company_id, debit, credit, checked) VALUES (@date, @account_id, @item_id, @company_id, @debit, @credit, @checked)', 'UPDATE cashbook SET date = @date, account_id = @account_id, item_id = @item_id, company_id = @company_id, debit = @debit, credit = @credit, @checked = @checked WHERE id = @id', 'DELETE FROM cashbook WHERE id = @id');

INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'cashbook', 'date', 'SelectPeriod', NULL, NULL, 'ATTRIBUTE', NULL, 'HideWeeks HideYears', NULL, NULL);

INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'start_date', 'SelectPeriod', NULL, NULL, 'ATTRIBUTE', NULL, 'end_date HideWeeks HideYears', NULL, NULL);

INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', NULL, 'Change', NULL, 'cashbook', 'TABLE', NULL, NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', 'account_id', 'ValidationList', NULL, 'accounts', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', 'company_id', 'ValidationList', NULL, 'companies', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', 'item_id', 'ValidationList', NULL, 'items', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', NULL, 'DoNotSave', NULL, NULL, 'ATTRIBUTE', NULL, NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook2', NULL, 'ProtectRows', NULL, NULL, 'ATTRIBUTE', NULL, NULL, NULL, NULL);

INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'account_id', 'ValidationList', NULL, 'accounts', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'company_id', 'ValidationList', NULL, 'companies', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'item_id', 'ValidationList', NULL, 'items', 'TABLE', 'id, +name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'debit', 'Change', NULL, 'view_cashbook3_debit_change', 'CODE', 'UPDATE cashbook SET debit = @cell_number_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'credit', 'Change', NULL, 'view_cashbook3_credit_change', 'CODE', 'UPDATE cashbook SET credit = @cell_number_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'account_id', 'Change', NULL, 'view_cashbook3_account_id_change', 'CODE', 'UPDATE cashbook SET account_id = @cell_number_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'company_id', 'Change', NULL, 'view_cashbook3_company_id_change', 'CODE', 'UPDATE cashbook SET company_id = @cell_number_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'item_id', 'Change', NULL, 'view_cashbook3_item_id_change', 'CODE', 'UPDATE cashbook SET item_id = @cell_number_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', 'date', 'Change', NULL, 'view_cashbook3_date_change', 'CODE', 'UPDATE cashbook SET [date] = @cell_datetime_value WHERE id = @id', '_Commit', NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', NULL, 'DoNotSave', NULL, NULL, 'ATTRIBUTE', NULL, NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'view_cashbook3', NULL, 'ProtectRows', NULL, NULL, 'ATTRIBUTE', NULL, NULL, NULL, NULL);

INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', NULL, 'Actions', NULL, 'See Online Help', 'HTTP', 'https://www.savetodb.com/samples/sample02-code_cashbook', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'account_id', 'ParameterValues', NULL, 'xl_list_account_id_code', 'CODE', 'SELECT
    m.id
    , COALESCE(t.TRANSLATED_NAME, m.name) AS name
FROM
    accounts m
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = m.name
ORDER BY
    name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'company_id', 'ParameterValues', NULL, 'xl_list_company_id_for_item_id_code', 'CODE', 'SELECT
    m.id
    , COALESCE(t.TRANSLATED_NAME, m.name) AS name
FROM
    companies m
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = m.name
WHERE
    @item_id IS NULL
UNION ALL
SELECT
    c.id
    , COALESCE(t.TRANSLATED_NAME, c.name) AS name
FROM
    item_companies ic
    INNER JOIN companies c ON c.id = ic.company_id
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = c.name
WHERE
    ic.item_id = @item_id
ORDER BY
    name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'item_id', 'ParameterValues', NULL, 'xl_list_item_id_code', 'CODE', 'SELECT
    m.id
    , COALESCE(t.TRANSLATED_NAME, m.name) AS name
FROM
    items m
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = m.name
ORDER BY
    name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'account_id', 'ValidationList', NULL, 'xl_list_account_id_code', 'CODE', 'SELECT
    m.id
    , COALESCE(t.TRANSLATED_NAME, m.name) AS name
FROM
    accounts m
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = m.name
ORDER BY
    name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'company_id', 'ValidationList', NULL, 'xl_list_company_id_with_item_id_code', 'CODE', 'SELECT
    c.id
    , COALESCE(t.TRANSLATED_NAME, c.name) AS name
    , ic.item_id
FROM
    item_companies ic
    INNER JOIN companies c ON c.id = ic.company_id
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = c.name
ORDER BY
    ic.item_id
    , name', NULL, NULL, NULL);
INSERT INTO handlers (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, EVENT_NAME, HANDLER_SCHEMA, HANDLER_NAME, HANDLER_TYPE, HANDLER_CODE, TARGET_WORKSHEET, MENU_ORDER, EDIT_PARAMETERS) VALUES (NULL, 'code_cashbook', 'item_id', 'ValidationList', NULL, 'xl_list_item_id_code', 'CODE', 'SELECT
    m.id
    , COALESCE(t.TRANSLATED_NAME, m.name) AS name
FROM
    items m
    LEFT OUTER JOIN translations t ON t.TABLE_NAME = ''strings''
            AND t.LANGUAGE_NAME = @data_language AND t.COLUMN_NAME = m.name
ORDER BY
    name', NULL, NULL, NULL);

INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','de','Konto','','');
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','de','Konto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','de','Apr.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','de','Aug.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','de','Balance', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','de','Überprüft', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','de','Unternehmen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','de','Unternehmen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','de','Kosten', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','de','Datum', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','de','Tag', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','de','Einkommen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','de','Dez.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','de','Endtermin', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','de','Feb.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','de','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','de','Artikel', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','de','Artikel', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','de','Jan.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','de','Juli', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','de','Juni', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','de','Niveau', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','de','März', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','de','Mai', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','de','Monat', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','de','Name', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','de','Nov.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','de','Okt.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','de','Sektion', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','de','Sept.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','de','Sortierung', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','de','Startdatum', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','de','Jahr', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'de','Konten', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'de','Kassenbuch', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'de','Kassenbuch (SQL-Code)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'de','Unternehmen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'de','Artikel und Firmen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'de','Artikel', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','de','Bank', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','de','Schlussbilanz', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','de','Körperschaftssteuer', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','de','Kunde C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','de','Kunde C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','de','Kunde C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','de','Kunde C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','de','Kunde C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','de','Kunde C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','de','Kunde C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','de','Kosten', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','de','Lohnsteuer', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','de','Nettoveränderung', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','de','Anfangsbestand', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','de','Lohn-und Gehaltsabrechnung', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','de','Sozialabgaben', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','de','Einnahmen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','de','Lieferant S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','de','Lieferant S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','de','Lieferant S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','de','Lieferant S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','de','Lieferant S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','de','Lieferant S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','de','Lieferant S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','de','Steuern', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','de','Gesamtausgaben', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','de','Gesamteinkommen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'de','Bargeld nach Monaten', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','de','Firmen-ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','de','Artikel-ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'de','Kassenbuch (Ansicht)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'de','Kassenbuch (Ansicht, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'de','Kassenbuch (Ansicht, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'de','Translationen', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'de','Einzelheiten', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','en','Account', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','en','Account', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','en','Apr', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','en','Aug', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','en','Balance', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','en','Checked', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','en','Company', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','en','Company', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','en','Expenses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','en','Date', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','en','Day', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','en','Income', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','en','Dec', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','en','End Date', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','en','Feb', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','en','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','en','Item', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','en','Item', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','en','Jan', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','en','Jul', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','en','Jun', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','en','Level', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','en','Mar', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','en','May', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','en','Month', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','en','Name', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','en','Nov', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','en','Oct', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','en','Section', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','en','Sep', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','en','Sort Order', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','en','Start Date', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','en','Year', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'en','Accounts', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'en','Cashbook', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'en','Cashbook (SQL code)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'en','Companies', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'en','Item and Companies', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'en','Items', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','en','Bank', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','en','Closing Balance', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','en','Corporate Income Tax', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','en','Customer C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','en','Customer C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','en','Customer C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','en','Customer C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','en','Customer C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','en','Customer C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','en','Customer C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','en','Expenses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','en','Individual Income Tax', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','en','Net Change', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','en','Opening Balance', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','en','Payroll', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','en','Payroll Taxes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','en','Revenue', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','en','Supplier S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','en','Supplier S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','en','Supplier S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','en','Supplier S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','en','Supplier S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','en','Supplier S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','en','Supplier S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','en','Taxes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','en','Total Expenses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','en','Total Income', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'en','Cash by Months', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','en','Company Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','en','Item Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'en','Cashbook (view)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'en','Cashbook (view, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'en','Cashbook (view, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'en','Translations', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'en','Details', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','es','Cuenta', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','es','Cuenta', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','es','Abr.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','es','Agosto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','es','Equilibrio', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','es','Comprobado', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','es','Empresa', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','es','Empresa', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','es','Gasto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','es','Fecha', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','es','Día', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','es','Ingresos', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','es','Dic.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','es','Fecha final', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','es','Feb.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','es','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','es','Artículo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','es','Artículo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','es','Enero', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','es','Jul.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','es','Jun.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','es','Nivel', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','es','Marzo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','es','Mayo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','es','Mes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','es','Nombre', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','es','Nov.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','es','Oct.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','es','Sección', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','es','Sept.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','es','Orden', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','es','Fecha de inicio', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','es','Año', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'es','Cuentas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'es','Libro de caja', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'es','Libro de caja (código SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'es','Compañías', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'es','Artículo y empresas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'es','Artículos', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','es','Banco', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','es','Balance de cierre', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','es','Impuesto sobre Sociedades', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','es','Cliente C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','es','Cliente C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','es','Cliente C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','es','Cliente C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','es','Cliente C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','es','Cliente C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','es','Cliente C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','es','Gasto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','es','IRPF', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','es','Cambio neto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','es','Saldo de apertura', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','es','Salario', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','es','Cargas sociales', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','es','Ingresos', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','es','Abastecedor A1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','es','Abastecedor A2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','es','Abastecedor A3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','es','Abastecedor A4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','es','Abastecedor A5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','es','Abastecedor A6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','es','Abastecedor A7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','es','Impuestos', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','es','Gasto total', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','es','Ingresos totales', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'es','Efectivo por meses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','es','ID de empresa', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','es','ID del artículo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'es','Libro de caja (ver)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'es','Libro de caja (ver, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'es','Libro de caja (ver, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'es','Traducciones', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'es','Detalles', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','fr','Compte', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','fr','Compte', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','fr','Avril', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','fr','Août', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','fr','Solde', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','fr','Vérifié', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','fr','Entreprise', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','fr','Entreprise', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','fr','Dépenses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','fr','Date', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','fr','Journée', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','fr','Revenu', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','fr','Déc.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','fr','Date de fin', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','fr','Févr.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','fr','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','fr','Article', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','fr','Article', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','fr','Janv.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','fr','Juil.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','fr','Juin', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','fr','Niveau', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','fr','Mars', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','fr','Mai', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','fr','Mois', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','fr','Prénom', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','fr','Nov.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','fr','Oct.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','fr','Section', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','fr','Sept.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','fr','Ordre de tri', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','fr','Date de début', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','fr','Année', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'fr','Comptes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'fr','Livre de caisse', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'fr','Livre de caisse (code SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'fr','Entreprises', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'fr','Article et sociétés', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'fr','Articles', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','fr','Banque', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','fr','Solde de clôture', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','fr','Impôt sur les sociétés', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','fr','Client 01', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','fr','Client 02', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','fr','Client 03', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','fr','Client 04', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','fr','Client 05', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','fr','Client 06', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','fr','Client 07', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','fr','Dépenses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','fr','Impôt sur le revenu', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','fr','Changement net', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','fr','Solde d''ouverture', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','fr','Paie', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','fr','Charges sociales', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','fr','Revenu', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','fr','Fournisseur 01', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','fr','Fournisseur 02', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','fr','Fournisseur 03', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','fr','Fournisseur 04', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','fr','Fournisseur 05', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','fr','Fournisseur 06', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','fr','Fournisseur 07', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','fr','Taxes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','fr','Dépenses totales', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','fr','Revenu total', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'fr','Cash par mois', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','fr','ID de l''entreprise', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','fr','ID de l''article', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'fr','Livre de caisse (vue)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'fr','Livre de caisse (vue, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'fr','Livre de caisse (vue, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'fr','Traductions', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'fr','Détails', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','it','Conto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','it','Conto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','it','Apr.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','it','Ag.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','it','Saldo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','it','Controllato', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','it','Azienda', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','it','Azienda', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','it','Credito', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','it','Data', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','it','Giorno', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','it','Debito', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','it','Dic.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','it','Data di fine', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','it','Febbr.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','it','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','it','Articolo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','it','Articolo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','it','Genn.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','it','Luglio', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','it','Giugno', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','it','Livello', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','it','Mar.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','it','Magg.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','it','Mese', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','it','Conome', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','it','Nov.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','it','Ott.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','it','Sezione', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','it','Sett.', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','it','Ordinamento', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','it','Data d''inizio', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','it','Anno', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'it','Conti', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'it','Cashbook', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'it','Cashbook (codice SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'it','Aziende', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'it','Articolo e società', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'it','Elementi', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','it','Banca', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','it','Saldo finale', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','it','Imposta sul reddito delle società', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','it','Cliente C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','it','Cliente C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','it','Cliente C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','it','Cliente C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','it','Cliente C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','it','Cliente C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','it','Cliente C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','it','Spese', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','it','IRPEF', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','it','Cambio netto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','it','Saldo iniziale', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','it','Paga', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','it','Imposte sui salari', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','it','Reddito', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','it','Fornitore F1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','it','Fornitore F2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','it','Fornitore F3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','it','Fornitore F4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','it','Fornitore F5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','it','Fornitore F6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','it','Fornitore F7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','it','Tasse', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','it','Spese totale', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','it','Reddito totale', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'it','Contanti per mesi', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','it','ID dell''azienda', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','it','ID articolo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'it','Cashbook (visualizza)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'it','Cashbook (visualizza, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'it','Cashbook (visualizza, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'it','Traduzioni', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'it','Dettagli', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','ja','アカウント', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','ja','アカウント', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','ja','4月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','ja','8月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','ja','バランス', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','ja','チェック済み', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','ja','会社', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','ja','会社', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','ja','経費', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','ja','日付', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','ja','日', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','ja','所得', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','ja','12月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','ja','終了日', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','ja','2月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','ja','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','ja','アイテム', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','ja','アイテム', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','ja','1月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','ja','7月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','ja','6月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','ja','レベル', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','ja','3月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','ja','5月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','ja','月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','ja','名', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','ja','11月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','ja','10月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','ja','セクション', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','ja','9月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','ja','並べ替え順序', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','ja','開始日', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','ja','年', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'ja','アカウント', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'ja','キャッシュブック', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'ja','キャッシュブック（SQLコード）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'ja','会社', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'ja','アイテムと会社', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'ja','アイテム', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','ja','銀行', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','ja','クロージングバランス', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','ja','法人所得税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','ja','顧客C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','ja','顧客C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','ja','顧客C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','ja','顧客C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','ja','顧客C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','ja','顧客C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','ja','顧客C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','ja','経費', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','ja','個人所得税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','ja','正味変化', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','ja','オープニングバランス', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','ja','給与', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','ja','給与税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','ja','収益', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','ja','サプライヤーS1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','ja','サプライヤーS2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','ja','サプライヤーS3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','ja','サプライヤーS4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','ja','サプライヤーS5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','ja','サプライヤーS6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','ja','サプライヤーS7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','ja','税金', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','ja','総費用', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','ja','総収入', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'ja','月ごとの現金', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','ja','会社ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','ja','アイテムID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'ja','キャッシュブック（表示）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'ja','キャッシュブック（表示、_変更）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'ja','キャッシュブック（表示、_変更、SQL）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'ja','翻訳', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'ja','詳細', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','ko','계정', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','ko','계정', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','ko','4월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','ko','8월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','ko','균형', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','ko','확인됨', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','ko','회사', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','ko','회사', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','ko','소요 경비', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','ko','날짜', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','ko','하루', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','ko','소득', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','ko','12월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','ko','종료일', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','ko','2월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','ko','ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','ko','아이템', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','ko','아이템', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','ko','1월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','ko','7월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','ko','6월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','ko','수준', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','ko','3월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','ko','5월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','ko','월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','ko','이름', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','ko','11월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','ko','10월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','ko','섹션', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','ko','9월', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','ko','정렬 순서', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','ko','시작일', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','ko','년', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'ko','계정', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'ko','캐쉬북', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'ko','캐쉬북(SQL 코드)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'ko','회사', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'ko','아이템 및 회사', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'ko','아이템', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','ko','은행', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','ko','폐쇄 균형', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','ko','법인 소득세', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','ko','고객 C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','ko','고객 C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','ko','고객 C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','ko','고객 C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','ko','고객 C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','ko','고객 C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','ko','고객 C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','ko','소요 경비', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','ko','개인소득세', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','ko','순 변화', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','ko','기초 잔액', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','ko','월급', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','ko','급여 세금', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','ko','수익', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','ko','공급 업체 S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','ko','공급 업체 S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','ko','공급 업체 S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','ko','공급 업체 S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','ko','공급 업체 S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','ko','공급 업체 S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','ko','공급 업체 S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','ko','세금', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','ko','총 경비', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','ko','총 수입', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'ko','월별 현금', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','ko','회사 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','ko','항목 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'ko','캐쉬북(보기)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'ko','캐쉬북(보기, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'ko','캐쉬북(보기, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'ko','번역', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'ko','세부', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','pt','Conta', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','pt','Conta', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','pt','Abr', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','pt','Agosto', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','pt','Saldo', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','pt','Verificado', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','pt','Companhia', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','pt','Companhia', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','pt','Despesas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','pt','Encontro', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','pt','Dia', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','pt','Renda', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','pt','Dez', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','pt','Data final', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','pt','Fev', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','pt','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','pt','Item', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','pt','Item', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','pt','Jan', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','pt','Julho', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','pt','Junho', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','pt','Nível', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','pt','Março', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','pt','Maio', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','pt','Mês', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','pt','Nome', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','pt','Nov', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','pt','Out', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','pt','Seção', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','pt','Set', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','pt','Ordem de classificação', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','pt','Data de início', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','pt','Ano', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'pt','Contas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'pt','Livro caixa', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'pt','Livro caixa (código SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'pt','Empresas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'pt','Item e Empresas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'pt','Itens', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','pt','Banco', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','pt','Saldo final', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','pt','Imposto de Renda', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','pt','Cliente C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','pt','Cliente C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','pt','Cliente C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','pt','Cliente C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','pt','Cliente C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','pt','Cliente C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','pt','Cliente C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','pt','Despesas', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','pt','Imposto de renda individual', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','pt','Mudança de rede', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','pt','Saldo inicial', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','pt','Folha de pagamento', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','pt','Impostos sobre os salários', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','pt','Receita', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','pt','Fornecedor S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','pt','Fornecedor S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','pt','Fornecedor S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','pt','Fornecedor S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','pt','Fornecedor S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','pt','Fornecedor S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','pt','Fornecedor S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','pt','Impostos', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','pt','Despesas totais', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','pt','Renda total', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'pt','Dinheiro por meses', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','pt','ID da empresa', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','pt','ID do item', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'pt','Livro caixa (ver)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'pt','Livro caixa (ver, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'pt','Livro caixa (ver, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'pt','Traduções', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'pt','Detalhes', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','ru','Счет', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','ru','Счет', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','ru','Апр', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','ru','Авг', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','ru','Остаток', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','ru','Проверено', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','ru','Компания', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','ru','Компания', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','ru','Расходы', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','ru','Дата', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','ru','Число', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','ru','Доходы', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','ru','Дек', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','ru','Конечная дата', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','ru','Фев', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','ru','Id', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','ru','Статья', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','ru','Статья', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','ru','Янв', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','ru','Июл', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','ru','Июн', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','ru','Уровень', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','ru','Мар', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','ru','Май', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','ru','Месяц', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','ru','Наименование', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','ru','Ноя', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','ru','Окт', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','ru','Секция', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','ru','Сен', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','ru','Порядок', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','ru','Начальная дата', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','ru','Год', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'ru','Счета', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'ru','Кассовая книга', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'ru','Кассовая книга (SQL код)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'ru','Компании', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'ru','Статьи и компании', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'ru','Статьи', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','ru','Банк', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','ru','Конечное сальдо', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','ru','Налог на прибыль', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','ru','Покупатель C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','ru','Покупатель C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','ru','Покупатель C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','ru','Покупатель C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','ru','Покупатель C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','ru','Покупатель C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','ru','Покупатель C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','ru','Расходы', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','ru','НДФЛ', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','ru','Изменение', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','ru','Начальное сальдо', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','ru','Заработная плата', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','ru','Страховые взносы', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','ru','Выручка', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','ru','Поставщик S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','ru','Поставщик S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','ru','Поставщик S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','ru','Поставщик S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','ru','Поставщик S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','ru','Поставщик S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','ru','Поставщик S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','ru','Налоги', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','ru','Всего выплаты', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','ru','Всего поступления', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'ru','ДДС по месяцам', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','ru','Id компании', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','ru','Id статьи', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'ru','Кассовая книга (view)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'ru','Кассовая книга (view, _change)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'ru','Кассовая книга (view, _change, SQL)', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'ru','Исходные данные', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','zh-hans','帐户', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','zh-hans','帐户', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','zh-hans','四月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','zh-hans','八月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','zh-hans','平衡', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','zh-hans','已检查', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','zh-hans','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','zh-hans','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','zh-hans','花费', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','zh-hans','日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','zh-hans','日', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','zh-hans','收入', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','zh-hans','十二月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','zh-hans','结束日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','zh-hans','二月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','zh-hans','ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','zh-hans','项', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','zh-hans','项', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','zh-hans','一月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','zh-hans','七月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','zh-hans','六月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','zh-hans','水平', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','zh-hans','三月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','zh-hans','五月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','zh-hans','月份', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','zh-hans','名称', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','zh-hans','十一月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','zh-hans','十月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','zh-hans','部分', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','zh-hans','九月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','zh-hans','排序顺序', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','zh-hans','开始日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','zh-hans','年', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'zh-hans','账户', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'zh-hans','现金簿', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'zh-hans','现金簿（SQL 代码）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'zh-hans','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'zh-hans','物品和公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'zh-hans','物品', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','zh-hans','银行', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','zh-hans','期末余额', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','zh-hans','公司所得税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','zh-hans','顾客C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','zh-hans','顾客C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','zh-hans','顾客C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','zh-hans','顾客C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','zh-hans','顾客C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','zh-hans','顾客C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','zh-hans','顾客C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','zh-hans','花费', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','zh-hans','个人所得税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','zh-hans','净变化', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','zh-hans','期初余额', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','zh-hans','工资单', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','zh-hans','工资税', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','zh-hans','营收', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','zh-hans','供应商 S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','zh-hans','供应商 S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','zh-hans','供应商 S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','zh-hans','供应商 S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','zh-hans','供应商 S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','zh-hans','供应商 S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','zh-hans','供应商 S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','zh-hans','税收', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','zh-hans','总费用', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','zh-hans','总收入', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'zh-hans','每月现金', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','zh-hans','公司 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','zh-hans','项目 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'zh-hans','现金簿（查看）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'zh-hans','现金簿（查看，_change）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'zh-hans','现金簿（视图、_change、SQL）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'zh-hans','翻译', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'zh-hans','详情', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account','zh-hant','帳戶', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'account_id','zh-hant','帳戶', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Apr','zh-hant','四月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Aug','zh-hant','八月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'balance','zh-hant','平衡', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'checked','zh-hant','已檢查', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company','zh-hant','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'company_id','zh-hant','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'credit','zh-hant','花費', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'date','zh-hant','日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'day','zh-hant','日', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'debit','zh-hant','收入', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Dec','zh-hant','十二月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'end_date','zh-hant','結束日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Feb','zh-hant','二月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'id','zh-hant','ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item','zh-hant','項', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'item_id','zh-hant','項', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jan','zh-hant','一月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jul','zh-hant','七月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Jun','zh-hant','六月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'level','zh-hant','水平', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Mar','zh-hant','三月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'May','zh-hant','五月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'month','zh-hant','月份', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Name','zh-hant','名稱', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Nov','zh-hant','十一月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Oct','zh-hant','十月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'section','zh-hant','部分', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'Sep','zh-hant','九月', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'sort_order','zh-hant','排序順序', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'start_date','zh-hant','開始日期', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL, NULL,'year','zh-hant','年', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'accounts', NULL,'zh-hant','賬戶', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'cashbook', NULL,'zh-hant','現金簿', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'code_cashbook', NULL,'zh-hant','現金簿（SQL 代碼）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'companies', NULL,'zh-hant','公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'item_companies', NULL,'zh-hant','物品和公司', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'items', NULL,'zh-hant','物品', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Bank','zh-hant','銀行', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Closing Balance','zh-hant','期末餘額', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Corporate Income Tax','zh-hant','公司所得稅', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C1','zh-hant','顧客C1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C2','zh-hant','顧客C2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C3','zh-hant','顧客C3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C4','zh-hant','顧客C4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C5','zh-hant','顧客C5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C6','zh-hant','顧客C6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Customer C7','zh-hant','顧客C7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Expenses','zh-hant','花費', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Individual Income Tax','zh-hant','個人所得稅', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Net Change','zh-hant','淨變化', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Opening Balance','zh-hant','期初餘額', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll','zh-hant','工資單', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Payroll Taxes','zh-hant','工資稅', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Revenue','zh-hant','營收', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S1','zh-hant','供應商 S1', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S2','zh-hant','供應商 S2', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S3','zh-hant','供應商 S3', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S4','zh-hant','供應商 S4', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S5','zh-hant','供應商 S5', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S6','zh-hant','供應商 S6', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Supplier S7','zh-hant','供應商 S7', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Taxes','zh-hant','稅收', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Expenses','zh-hant','總費用', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'strings','Total Income','zh-hant','總收入', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months', NULL,'zh-hant','每月現金', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','company_id','zh-hant','公司 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'usp_cash_by_months','item_id','zh-hant','項目 ID', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook', NULL,'zh-hant','现金簿（查看）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook2', NULL,'zh-hant','现金簿（查看，_change）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'view_cashbook3', NULL,'zh-hant','现金簿（视图、_change、SQL）', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'translations', NULL,'zh-hant','翻译', NULL, NULL);
INSERT INTO translations (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, LANGUAGE_NAME, TRANSLATED_NAME, TRANSLATED_DESC, TRANSLATED_COMMENT) VALUES (NULL,'xl_details_cash_by_months', NULL,'zh-hant','詳情', NULL, NULL);

INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'accounts', '<table name="accounts"><columnFormats><column name="" property="ListObjectName" value="accounts" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="5" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="name" property="Address" value="$D$4" type="String"/><column name="name" property="ColumnWidth" value="27.86" type="Double"/><column name="name" property="NumberFormat" value="General" type="String"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/><column name="" property="PageSetup.PaperSize" value="1" type="Double"/></columnFormats></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'items', '<table name="items"><columnFormats><column name="" property="ListObjectName" value="items" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="5" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="name" property="Address" value="$D$4" type="String"/><column name="name" property="ColumnWidth" value="27.86" type="Double"/><column name="name" property="NumberFormat" value="General" type="String"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/><column name="" property="PageSetup.PaperSize" value="1" type="Double"/></columnFormats></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'companies', '<table name="companies"><columnFormats><column name="" property="ListObjectName" value="companies" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="5" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="name" property="Address" value="$D$4" type="String"/><column name="name" property="ColumnWidth" value="27.86" type="Double"/><column name="name" property="NumberFormat" value="General" type="String"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/><column name="" property="PageSetup.PaperSize" value="1" type="Double"/></columnFormats></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'item_companies', '<table name="item_companies"><columnFormats><column name="" property="ListObjectName" value="item_companies" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$C$4" type="String"/><column name="item_id" property="ColumnWidth" value="27.86" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$D$4" type="String"/><column name="company_id" property="ColumnWidth" value="27.86" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="_State_" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="_State_" property="Address" value="$E$4" type="String"/><column name="_State_" property="ColumnWidth" value="9.14" type="Double"/><column name="_State_" property="NumberFormat" value="General" type="String"/><column name="_State_" property="HorizontalAlignment" value="-4108" type="Double"/><column name="_State_" property="Font.Size" value="10" type="Double"/><column name="_State_" property="FormatConditions(1).AppliesTo.Address" value="$E$4:$E$20" type="String"/><column name="_State_" property="FormatConditions(1).Type" value="6" type="Double"/><column name="_State_" property="FormatConditions(1).Priority" value="1" type="Double"/><column name="_State_" property="FormatConditions(1).ShowIconOnly" value="True" type="Boolean"/><column name="_State_" property="FormatConditions(1).IconSet.ID" value="8" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(1).Type" value="3" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(1).Operator" value="7" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(2).Type" value="0" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(2).Value" value="0.5" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(2).Operator" value="7" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(3).Type" value="0" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(3).Value" value="1" type="Double"/><column name="_State_" property="FormatConditions(1).IconCriteria(3).Operator" value="7" type="Double"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'usp_cash_by_months', '<table name="usp_cash_by_months"><columnFormats><column name="" property="ListObjectName" value="Sheet1_Table16" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium15" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="sort_order" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="sort_order" property="Address" value="$C$4" type="String"/><column name="sort_order" property="NumberFormat" value="General" type="String"/><column name="section" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="section" property="Address" value="$D$4" type="String"/><column name="section" property="NumberFormat" value="General" type="String"/><column name="level" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="level" property="Address" value="$E$4" type="String"/><column name="level" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Name" property="Address" value="$H$4" type="String"/><column name="Name" property="ColumnWidth" value="21.43" type="Double"/><column name="Name" property="NumberFormat" value="General" type="String"/><column name="Total" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Total" property="Address" value="$I$4" type="String"/><column name="Total" property="ColumnWidth" value="8.43" type="Double"/><column name="Total" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="Address" value="$J$4" type="String"/><column name="Jan" property="ColumnWidth" value="10" type="Double"/><column name="Jan" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="Address" value="$K$4" type="String"/><column name="Feb" property="ColumnWidth" value="10" type="Double"/><column name="Feb" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="Address" value="$L$4" type="String"/><column name="Mar" property="ColumnWidth" value="10" type="Double"/><column name="Mar" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="Address" value="$M$4" type="String"/><column name="Apr" property="ColumnWidth" value="10" type="Double"/><column name="Apr" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="Address" value="$N$4" type="String"/><column name="May" property="ColumnWidth" value="10" type="Double"/><column name="May" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="Address" value="$O$4" type="String"/><column name="Jun" property="ColumnWidth" value="10" type="Double"/><column name="Jun" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="Address" value="$P$4" type="String"/><column name="Jul" property="ColumnWidth" value="10" type="Double"/><column name="Jul" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="Address" value="$Q$4" type="String"/><column name="Aug" property="ColumnWidth" value="10" type="Double"/><column name="Aug" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="Address" value="$R$4" type="String"/><column name="Sep" property="ColumnWidth" value="10" type="Double"/><column name="Sep" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="Address" value="$S$4" type="String"/><column name="Oct" property="ColumnWidth" value="10" type="Double"/><column name="Oct" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="Address" value="$T$4" type="String"/><column name="Nov" property="ColumnWidth" value="10" type="Double"/><column name="Nov" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="Address" value="$U$4" type="String"/><column name="Dec" property="ColumnWidth" value="10" type="Double"/><column name="Dec" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="_RowNum" property="FormatConditions(1).AppliesToTable" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(1).AppliesTo.Address" value="$B$4:$U$20" type="String"/><column name="_RowNum" property="FormatConditions(1).Type" value="2" type="Double"/><column name="_RowNum" property="FormatConditions(1).Priority" value="3" type="Double"/><column name="_RowNum" property="FormatConditions(1).Formula1" value="=$E4&lt;2" type="String"/><column name="_RowNum" property="FormatConditions(1).Font.Bold" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).AppliesToTable" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).AppliesTo.Address" value="$B$4:$U$20" type="String"/><column name="_RowNum" property="FormatConditions(2).Type" value="2" type="Double"/><column name="_RowNum" property="FormatConditions(2).Priority" value="4" type="Double"/><column name="_RowNum" property="FormatConditions(2).Formula1" value="=AND($E4=0,$D4&gt;1,$D4&lt;5)" type="String"/><column name="_RowNum" property="FormatConditions(2).Font.Bold" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).Font.Color" value="16777215" type="Double"/><column name="_RowNum" property="FormatConditions(2).Font.ThemeColor" value="1" type="Double"/><column name="_RowNum" property="FormatConditions(2).Font.TintAndShade" value="0" type="Double"/><column name="_RowNum" property="FormatConditions(2).Interior.Color" value="6773025" type="Double"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All columns"><column name="" property="ListObjectName" value="cash_by_month" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="sort_order" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="section" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="level" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Default"><column name="" property="ListObjectName" value="cash_by_month" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="sort_order" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="section" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="level" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/></view></views></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'cashbook', '<table name="cashbook"><columnFormats><column name="" property="ListObjectName" value="cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="Address" value="$E$4" type="String"/><column name="account_id" property="ColumnWidth" value="12.14" type="Double"/><column name="account_id" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="ColumnWidth" value="20.71" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="ColumnWidth" value="20.71" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'view_cashbook', '<table name="view_cashbook"><columnFormats><column name="" property="ListObjectName" value="view_cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="Address" value="$E$4" type="String"/><column name="account_id" property="ColumnWidth" value="12.14" type="Double"/><column name="account_id" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="ColumnWidth" value="20.71" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="ColumnWidth" value="20.71" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'view_cashbook2', '<table name="view_cashbook2"><columnFormats><column name="" property="ListObjectName" value="view_cashbook2" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="Address" value="$E$4" type="String"/><column name="account_id" property="ColumnWidth" value="12.14" type="Double"/><column name="account_id" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="ColumnWidth" value="20.71" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="ColumnWidth" value="20.71" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'view_cashbook3', '<table name="view_cashbook3"><columnFormats><column name="" property="ListObjectName" value="view_cashbook3" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="Address" value="$E$4" type="String"/><column name="account_id" property="ColumnWidth" value="12.14" type="Double"/><column name="account_id" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="ColumnWidth" value="20.71" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="ColumnWidth" value="20.71" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES (NULL, 'code_cashbook', '<table name="code_cashbook"><columnFormats><column name="" property="ListObjectName" value="usp_cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="Address" value="$E$4" type="String"/><column name="account_id" property="ColumnWidth" value="12.14" type="Double"/><column name="account_id" property="NumberFormat" value="General" type="String"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="Address" value="$F$4" type="String"/><column name="item_id" property="ColumnWidth" value="20.71" type="Double"/><column name="item_id" property="NumberFormat" value="General" type="String"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="Address" value="$G$4" type="String"/><column name="company_id" property="ColumnWidth" value="20.71" type="Double"/><column name="company_id" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company_id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');

INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (SaveToDB Framework).xlsx', 'https://www.savetodb.com/downloads/v10/sample02-user3.xlsx','cashbook=cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":null,"item_id":null,"company_id":null},"ListObjectName":"cashbook"}
view_cashbook=view_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":null,"item_id":null,"company_id":null},"ListObjectName":"view_cashbook"}
view_cashbook2=view_cashbook2,(Default),False,$B$3,,{"Parameters":{"account_id":null,"item_id":null,"company_id":null},"ListObjectName":"view_cashbook2"}
view_cashbook3=view_cashbook3,(Default),False,$B$3,,{"Parameters":{"account_id":null,"item_id":null,"company_id":null},"ListObjectName":"view_cashbook3"}
code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null},"ListObjectName":"code_cashbook"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months"}
objects=objects,(Default),False,$B$3,,{"Parameters":{"TABLE_NAME":null,"TABLE_TYPE":null},"ListObjectName":"objects"}
handlers=handlers,(Default),False,$B$3,,{"Parameters":{"EVENT_NAME":null,"HANDLER_TYPE":null},"ListObjectName":"handlers"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"LANGUAGE_NAME":"en"},"ListObjectName":"translations"}
workbooks=workbooks,(Default),False,$B$3,,{"Parameters":{},"ListObjectName":"workbooks"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-en.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"en"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"en"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"en"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"en"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Chinese Simplified).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-zh-hans.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"zh-hans"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"zh-hans"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"zh-hans"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"zh-hans"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Chinese Traditional).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-zh-hant.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"zh-hant"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"zh-hant"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"zh-hant"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"zh-hant"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, French).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-fr.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"fr"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"fr"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"fr"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"fr"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, German).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-de.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"de"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"de"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"de"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"de"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Italian).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-it.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"it"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"it"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"it"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"it"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Japanese).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-ja.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"ja"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"ja"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"ja"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"ja"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Korean).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-ko.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"ko"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"ko"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"ko"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"ko"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Portuguese).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-pt.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"pt"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"pt"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"pt"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"pt"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Russian).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-ru.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"ru"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"ru"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"ru"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"ru"}', NULL);
INSERT INTO workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 02 - Advanced Features - User3 (Translation, Spanish).xlsx','https://www.savetodb.com/downloads/v10/sample02-user3-es.xlsx','code_cashbook=code_cashbook,(Default),False,$B$3,,{"Parameters":{"account_id":1,"item_id":null,"company_id":null,"start_date":null,"end_date":null,"checked":null},"ListObjectName":"code_cashbook","UseTranslatedName":true,"WorkbookLanguage":"es"}
cash_by_months=usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2022},"ListObjectName":"cash_by_months","UseTranslatedName":true,"WorkbookLanguage":"es"}
translations=translations,(Default),False,$B$3,,{"Parameters":{"TABLE_SCHEMA":"s02","LANGUAGE_NAME":"es"},"ListObjectName":"translations","UseTranslatedName":true,"WorkbookLanguage":"es"}', NULL);

-- print Application installed
