-- =============================================
-- Application: Sample 07 - Master Data Editor
-- Version 10.6, December 13, 2022
--
-- Copyright 2017-2022 Gartle LLC
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
