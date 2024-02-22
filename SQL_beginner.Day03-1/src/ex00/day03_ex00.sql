WITH kate AS (
    SELECT id AS wtf 
    FROM person
    WHERE name = 'Kate' AND id = 3
)
SELECT 
    menu.pizza_name,
    menu.price,
    pizzeria.name AS pizzeria_name, 
    person_visits.visit_date
    
FROM 
    menu 
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
JOIN kate ON person_visits.person_id = kate.wtf
WHERE 
    menu.price BETWEEN 800 AND 1000
ORDER BY menu.pizza_name, menu.price,pizzeria_name;


