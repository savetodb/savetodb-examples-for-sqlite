-- =============================================
-- Application: Sample 07 - Master Data Editor
-- Version 10.8, January 9, 2023
--
-- Copyright 2017-2023 Gartle LLC
--
-- License: MIT
-- =============================================

SELECT
    t.type
    , t.name
FROM
    sqlite_master t
WHERE
    t.name NOT IN ('sqlite_sequence')
    AND t.type IN ('table', 'view')
ORDER BY
    t.type,
    t.name;
