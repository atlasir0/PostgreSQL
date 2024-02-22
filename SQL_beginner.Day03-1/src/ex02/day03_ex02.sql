
WITH d AS (
  SELECT id AS menu_id
  FROM menu
  EXCEPT
  SELECT menu_id
  FROM person_order
)
SELECT menu.pizza_name, menu.price, pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
WHERE menu.id IN (SELECT menu_id FROM d)
ORDER BY menu.pizza_name, menu.price;
