CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE(num BIGINT) AS $$
WITH RECURSIVE fibonacci(current, next) AS (
  SELECT 0, 1
  UNION ALL
  SELECT next, current + next
  FROM fibonacci
  WHERE pstop > next
)
SELECT current FROM fibonacci;
$$ LANGUAGE sql;

DROP FUNCTION IF EXISTS fnc_fibonacci(pstop INTEGER);
SELECT * FROM fnc_fibonacci(100);

SELECT * FROM fnc_fibonacci();