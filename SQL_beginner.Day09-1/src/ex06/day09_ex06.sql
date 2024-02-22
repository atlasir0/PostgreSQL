CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date (pperson VARCHAR DEFAULT 'Dmitriy', pprice NUMERIC DEFAULT 500, pdate DATE DEFAULT '2022-01-08')
RETURNS TABLE (pizzeria_name VARCHAR) AS $$
BEGIN
RETURN QUERY
SELECT pizzeria.name
FROM pizzeria
     INNER JOIN menu
              ON menu.pizzeria_id = pizzeria.id
     INNER JOIN person_visits
              ON person_visits.pizzeria_id = pizzeria.id
     INNER JOIN person
              ON person.id = person_visits.person_id
WHERE pperson = person.name AND pprice > menu.price AND pdate = person_visits.visit_date;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);

SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
