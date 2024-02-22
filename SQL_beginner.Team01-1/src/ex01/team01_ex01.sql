insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

CREATE OR REPLACE FUNCTION fnc_get_currency_name(curr_id INTEGER)
RETURNS VARCHAR AS $$
    DECLARE c_name VARCHAR;
    BEGIN
        SELECT currency.name INTO c_name FROM currency WHERE curr_id = currency.id;
        RETURN c_name;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fnc_get_rate_to_usd(curr_id INTEGER, time_to_update_balance TIMESTAMP)
RETURNS NUMERIC AS $$
    DECLARE usd_rate NUMERIC;
    BEGIN
            SELECT rate_to_usd INTO usd_rate
            FROM (((SELECT currency.rate_to_usd, currency.updated FROM currency 
                WHERE currency.id = curr_id AND currency.updated < time_to_update_balance 
                ORDER BY currency.updated DESC LIMIT 1) 
            UNION
                (SELECT currency.rate_to_usd, currency.updated FROM currency 
                WHERE currency.id = curr_id AND time_to_update_balance < currency.updated 
                ORDER BY currency.updated LIMIT 1)) ORDER BY updated) AS t1_and_t2;
        RETURN usd_rate;
    END;
$$ LANGUAGE plpgsql;


SELECT COALESCE(users.name, 'not defined') AS name,
       COALESCE(users.lastname, 'not defined') AS lastname,
       COALESCE(fnc_get_currency_name(balance.currency_id), 'not defined') AS currency_name,
       fnc_get_rate_to_usd(balance.currency_id, balance.updated) * balance.money AS currency_in_usd
FROM balance
LEFT JOIN "user" users ON balance.user_id = users.id
WHERE fnc_get_currency_name(balance.currency_id) IS NOT NULL AND
      fnc_get_rate_to_usd(balance.currency_id, balance.updated) IS NOT NULL
ORDER BY name DESC, lastname, currency_name;