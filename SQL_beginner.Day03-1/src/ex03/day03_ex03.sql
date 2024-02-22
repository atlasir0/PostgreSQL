WITH pizzeria_visits AS (
    SELECT
        pizzeria.name AS pizzeria_name,
        SUM(CASE WHEN person.gender = 'female' THEN 1 ELSE 0 END) AS female_visits,
        SUM(CASE WHEN person.gender = 'male' THEN 1 ELSE 0 END) AS male_visits
    FROM
        person
    JOIN person_visits ON person_visits.person_id = person.id
    JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    GROUP BY pizzeria_name
)
SELECT pizzeria_name
FROM pizzeria_visits
WHERE female_visits > male_visits OR female_visits < male_visits
ORDER BY pizzeria_name;


