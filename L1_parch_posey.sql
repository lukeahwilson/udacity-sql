-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L#_parch_posey.sql'

-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER BY account_id, total_amt_usd DESC;

-- SELECT name, website, primary_poc
-- FROM accounts
-- WHERE name = 'Exxon Mobil';

-- SELECT id, account_id,
--    poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
-- FROM orders
-- LIMIT 10;

-- SELECT name
-- FROM accounts
-- WHERE name LIKE '%s';

-- SELECT *
-- FROM web_events
-- WHERE channel IN ('organic', 'adwords');

-- SELECT name
-- FROM accounts
-- WHERE name NOT LIKE '%s';

-- SELECT *
-- FROM web_events
-- WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
-- ORDER BY occurred_at DESC;

-- SELECT *
-- FROM accounts
-- WHERE (name LIKE 'C%' OR name LIKE 'W%')
--            AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
--            AND primary_poc NOT LIKE '%eana%');
