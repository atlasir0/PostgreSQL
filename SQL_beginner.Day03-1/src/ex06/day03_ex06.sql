
SELECT
    menu1.pizza_name,
    pizzeria1.name AS pizzeria_name_1,
    pizzeria2.name AS pizzeria_name_2,
    menu1.price
FROM
    menu AS  menu1
JOIN menu menu2 ON
    menu1.price = menu2.price AND
    menu1.pizza_name = menu2.pizza_name AND
    menu1.id <> menu2.id
JOIN pizzeria pizzeria1 ON
    pizzeria1.id = menu1.pizzeria_id
JOIN pizzeria pizzeria2 ON
    pizzeria2.id = menu2.pizzeria_id
WHERE
    pizzeria1.id > pizzeria2.id
ORDER BY
    menu1.pizza_name;
