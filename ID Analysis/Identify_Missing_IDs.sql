-- Identify missing records in an SQLite table for autoincrementing primary keys
-- Change table_name with the table you want to analyze
-- Author: Damien Attoe
-- Note: This will only work when the ID value is less than 1000

WITH RECURSIVE id_values(n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM id_values
  WHERE n < (SELECT seq FROM sqlite_sequence WHERE name = 'table_name')
)
SELECT n AS missing_ids
FROM id_values
WHERE n NOT IN (SELECT id FROM table_name)
ORDER BY missing_ids;
