INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES 
((generate_series((SELECT max(id)+1 FROM person_order), (SELECT max(id)+(SELECT max(id) FROM person) FROM person_order))),
(generate_series((SELECT min(id) FROM person),
 (SELECT max(id) FROM person))), (SELECT id FROM menu WHERE pizza_name = 'greek pizza'), '2022-02-25');



   insert into person_order(id,person_id,menu_id,order_date)
      select
          g+(select max(id) from person_order) as id,
          id as person_id,
          (select id from menu where pizza_name = 'greek pizza') as menu_id,
          '2022-02-25' as order_date
      from person inner join
      generate_series(1,(select count(*) from person)) as g on g= person.id