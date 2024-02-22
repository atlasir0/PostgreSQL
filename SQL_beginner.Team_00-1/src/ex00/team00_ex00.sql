CREATE TABLE nodes(
  point1 VARCHAR(1),
  point2 VARCHAR(1),
  cost INT
);
INSERT INTO nodes(point1, point2, cost)
VALUES
  ('a', 'b', 10),
  ('b', 'a', 10),
  ('a', 'c', 15),
  ('c', 'a', 15),
  ('a', 'd', 20),
  ('d', 'a', 20),
  ('b', 'd', 25),
  ('d', 'b', 25),
  ('c', 'd', 30),
  ('d', 'c', 30),
  ('b', 'c', 35),
  ('c', 'b', 35);
WITH RECURSIVE seeking AS (
  SELECT
    point2,
    ('{' || point1) AS tour,
    cost AS total_cost
  FROM
    nodes
  WHERE
    point1 = 'a' 
  UNION ALL
  SELECT
    nodes.point2,
    (seeking.tour || ',' || nodes.point1) AS tour,
    seeking.total_cost + nodes.cost AS total_cost
  FROM
    nodes
    JOIN seeking ON seeking.point2 = nodes.point1
  WHERE
    tour NOT LIKE ('%' || nodes.point1 || '%')
),
result AS (
  SELECT
    total_cost,  
    (tour || ',a}') AS tour
  FROM
    seeking
  WHERE
    point2 = 'a'
    AND LENGTH(tour) = 8
),
min_result AS (
  SELECT
    *
  FROM
    result
  WHERE  
    total_cost = (
      SELECT
        MIN(total_cost)
      FROM
        result
    )   
)
SELECT
  *
FROM
  min_result
ORDER BY
  total_cost,
  tour;