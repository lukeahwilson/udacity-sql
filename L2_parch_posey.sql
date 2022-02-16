-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L2_parch_posey.sql'

https://classroom.udacity.com/courses/ud198/lessons/8f23fc69-7c88-4a94-97a4-d5f6ef51cf7b/concepts/e12ccca0-1634-44a4-b34a-0344c07f3652

-- SELECT a.primary_poc, w.occurred_at, w.channel, a.name
-- FROM web_events w
-- JOIN accounts a
-- ON w.account_id = a.id
-- WHERE a.name = 'Walmart';

-- SELECT r.name region, s.name rep, a.name account
-- FROM sales_reps s
-- JOIN region r
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- ORDER BY a.name;

-- SELECT r.name region, a.name account,
--        o.total_amt_usd/(o.total + 0.01) unit_price
-- FROM region r
-- JOIN sales_reps s
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- JOIN orders o
-- ON o.account_id = a.id;

-- SELECT c.countryid, c.countryName, s.stateName
-- FROM Country c
-- LEFT JOIN State s
-- ON c.countryid = s.countryid;

-- SELECT c.countryid, c.countryName, s.stateName
-- FROM State s
-- LEFT JOIN Country c
-- ON c.countryid = s.countryid;

-- SELECT r.name region, s.name rep, a.name account
-- FROM sales_reps s
-- JOIN region r
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
-- ORDER BY a.name;

-- SELECT r.name region, s.name rep, a.name account
-- FROM sales_reps s
-- JOIN region r
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
-- ORDER BY a.name;

-- SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
-- FROM region r
-- JOIN sales_reps s
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- JOIN orders o
-- ON o.account_id = a.id
-- WHERE o.standard_qty > 100;

-- SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
-- FROM region r
-- JOIN sales_reps s
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- JOIN orders o
-- ON o.account_id = a.id
-- WHERE o.standard_qty > 100 AND o.poster_qty > 50
-- ORDER BY unit_price;

-- SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
-- FROM region r
-- JOIN sales_reps s
-- ON s.region_id = r.id
-- JOIN accounts a
-- ON a.sales_rep_id = s.id
-- JOIN orders o
-- ON o.account_id = a.id
-- WHERE o.standard_qty > 100 AND o.poster_qty > 50
-- ORDER BY unit_price DESC;
