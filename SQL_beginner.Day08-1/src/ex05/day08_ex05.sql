--  Session #1
BEGIN;
--  Session #2
BEGIN;
--  Session #1
SELECT SUM(rating) FROM pizzeria;
--  Session #2
UPDATE pizzeria SET rating = 1 WHERE name = 'Pizza Hut';
--  Session #2
COMMIT;
--  Session #1
SELECT SUM(rating) FROM pizzeria;
--  Session #1
COMMIT;
--  Session #1
SELECT SUM(rating) FROM pizzeria;
--  Session #2
SELECT SUM(rating) FROM pizzeria;
