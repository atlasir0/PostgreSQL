CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
WITH find_pizzeria AS (
    SELECT person_visits.pizzeria_id
    FROM person_visits
    INNER JOIN person ON person.id = person_id
    INNER JOIN menu ON menu.pizzeria_id = person_visits.pizzeria_id
    WHERE person.name = 'Dmitriy' AND visit_date = '2022-01-08' AND menu.price < 800
)
SELECT name
FROM pizzeria
INNER JOIN find_pizzeria ON find_pizzeria.pizzeria_id = id;