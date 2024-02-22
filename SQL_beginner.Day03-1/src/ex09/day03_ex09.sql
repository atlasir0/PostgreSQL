-- Пожалуйста, зарегистрируйте новые посещения ресторана Dominos от Дениса и Ирины 24 февраля 2022 года. Внимание: это упражнение, вероятно, станет причиной неправильного изменения данных. Собственно, восстановить исходную модель базы данных можно с помощью данных по ссылке в разделе «Правила дня» и сценария повтора из Упражнений 07 и 08.


INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
VALUES ((SELECT MAX(id)+1 FROM person_visits),
        (SELECT id FROM person WHERE name = 'Denis'), (SELECT id FROM pizzeria WHERE name = 'Dominos'),'2022-02-24'),
       ((SELECT MAX(id)+2 FROM person_visits),
        (SELECT id FROM person WHERE name = 'Irina'),(SELECT id FROM pizzeria WHERE name = 'Dominos'), '2022-02-24');



