
WITH Andrey AS (
    SELECT pizzeria.name AS pizzeria_name, person_visits.visit_date
    FROM person_visits 
        JOIN person ON person_visits.person_id = person.id
        JOIN person_order  ON person_order.person_id = person.id
        JOIN pizzeria  ON pizzeria.id = person_visits.pizzeria_id
    WHERE person.name = 'Andrey' AND visit_date <> order_date
)

SELECT DISTINCT pizzeria_name
FROM Andrey


