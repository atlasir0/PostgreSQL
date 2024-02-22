
WITH usd AS (
    SELECT 
        currency.id AS currency_id,
        currency.name AS currency_name,
        currency.rate_to_usd AS last_rate_to_usd
    FROM currency 
    INNER JOIN (
        SELECT 
            id, MAX(updated) AS max_updated
        FROM currency
        GROUP BY id
    ) latest ON currency.id = latest.id AND currency.updated = latest.max_updated
)

SELECT
    COALESCE("user".name, 'not defined') AS name,
    COALESCE("user".lastname, 'not defined') AS lastname,
    balance.type AS type,
    SUM(balance.money) AS volume,
    COALESCE(currency.currency_name, 'not defined') AS currency_name,
    COALESCE(currency.last_rate_to_usd, 1) AS last_rate_to_usd,
    SUM(balance.money * COALESCE(currency.last_rate_to_usd, 1)) AS total_volume_in_usd
FROM "user" 
FULL JOIN balance ON "user".id = balance.user_id
FULL JOIN usd currency ON balance.currency_id = currency.currency_id
GROUP BY "user".name, "user".lastname, balance.type, currency.currency_name, currency.last_rate_to_usd
ORDER BY 1 DESC, 2, 3;

