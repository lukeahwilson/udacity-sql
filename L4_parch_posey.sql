-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L4_parch_posey.sql'

-- SELECT channel, AVG(event_count) AS avg_event_count
-- 	FROM(
-- 	SELECT DATE_TRUNC('day', occurred_at) AS day,
-- 			channel, COUNT(*) AS event_count
-- 	FROM web_events
-- 	GROUP BY 1,2
-- 	) AS sub
-- 	GROUP BY 1
-- 	ORDER BY 2 DESC

-- SELECT channel, AVG(number_events) AS avg_number_events
-- FROM(
-- SELECT DATE_TRUNC('day', occurred_at) AS day, channel, COUNT(*) AS number_events
-- 	FROM web_events
-- 	GROUP BY 1,2
-- ) AS number_events_table
-- GROUP BY 1
-- ORDER BY 2 DESC

-- SELECT day, AVG(number_events) AS avg_number_events
-- FROM(
-- SELECT DATE_PART('dow', occurred_at) AS day, channel, COUNT(*) AS number_events
-- 	FROM web_events
-- 	GROUP BY 1,2
-- ) AS number_events_table
-- GROUP BY 1
-- ORDER BY 2 DESC

-- SELECT DATE_PART('month', occurred_at) AS first_month,
-- 	AVG(standard_qty) AS avg_stand,
-- 	AVG(gloss_qty) AS avg_gloss,
-- 	AVG(poster_qty) AS avg_poster,
-- 	SUM(total_amt_usd) AS total_spent
-- FROM orders
-- WHERE DATE_TRUNC('month',occurred_at) =
-- 	(SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min_month
-- 	FROM orders)
-- GROUP BY 1
-- LIMIT 10;

-- For the customer that had the largest total spent, how many web_events did they have for each channel?
	-- SELECT a.id, a.name, w.channel, COUNT(*) AS channel_frequency
	-- FROM accounts AS a
	-- JOIN web_events AS w
	-- ON a.id = w.account_id
	-- WHERE a.id =
	-- 	(SELECT a.id
	-- 	FROM accounts AS a
	-- 	JOIN orders AS o
	-- 	ON o.account_id = a.id
	-- 	WHERE o.total_amt_usd =
	-- 		(SELECT MAX(total_amt_usd) AS max_spent
	-- 		FROM orders))
	-- GROUP BY 1,2,3
	-- ORDER BY 3;

-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
	-- SELECT t3.rep_name, t3.region_name, t3.total_amt
	-- FROM(SELECT region_name, MAX(total_amt) total_amt
	--      FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
	--              FROM sales_reps s
	--              JOIN accounts a
	--              ON a.sales_rep_id = s.id
	--              JOIN orders o
	--              ON o.account_id = a.id
	--              JOIN region r
	--              ON r.id = s.region_id
	--              GROUP BY 1, 2) t1
	--      GROUP BY 1) t2
	-- JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
	--      FROM sales_reps s
	--      JOIN accounts a
	--      ON a.sales_rep_id = s.id
	--      JOIN orders o
	--      ON o.account_id = a.id
	--      JOIN region r
	--      ON r.id = s.region_id
	--      GROUP BY 1,2
	--      ORDER BY 3 DESC) t3
	-- ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

-- What is the lifetime average amount spent in terms of total_amt_usd,
-- including only the companies that spent more per order, on average, than the average of all orders.
	-- SELECT AVG(avg_amt)
	-- FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
	--     FROM orders o
	--     GROUP BY 1
	--     HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
	--                                    FROM orders o)) temp_table;

-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
	-- SELECT COUNT(*)
	-- FROM (SELECT a.name
	--       FROM orders o
	--       JOIN accounts a
	--       ON a.id = o.account_id
	--       GROUP BY 1
	--       HAVING SUM(o.total) > (SELECT total
	--                   FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
	--                         FROM accounts a
	--                         JOIN orders o
	--                         ON o.account_id = a.id
	--                         GROUP BY 1
	--                         ORDER BY 2 DESC
	--                         LIMIT 1) inner_tab)
	--             ) counter_tab;

-- For the region with the largest sales total_amt_usd, how many total orders were placed?
	-- SELECT r.name, COUNT(o.total) total_orders
	-- FROM sales_reps s
	-- JOIN accounts a
	-- ON a.sales_rep_id = s.id
	-- JOIN orders o
	-- ON o.account_id = a.id
	-- JOIN region r
	-- ON r.id = s.region_id
	-- GROUP BY r.name
	-- HAVING SUM(o.total_amt_usd) = (
	--       SELECT MAX(total_amt)
	--       FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
	--               FROM sales_reps s
	--               JOIN accounts a
	--               ON a.sales_rep_id = s.id
	--               JOIN orders o
	--               ON o.account_id = a.id
	--               JOIN region r
	--               ON r.id = s.region_id
	--               GROUP BY r.name) sub);

-- What is the lifetime average amount spent in terms of total_amt_usd,
-- including only the companies that spent more per order, on average, than the average of all orders.
	-- SELECT AVG(avg_amt)
	-- FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
	--     FROM orders o
	--     GROUP BY 1
	--     HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
	--                                    FROM orders o)) temp_table;

-- WITH events AS (
--           SELECT DATE_TRUNC('day',occurred_at) AS day,
--                         channel, COUNT(*) as events
--           FROM web_events
--           GROUP BY 1,2)

-- SELECT channel, AVG(events) AS average_events
-- FROM events
-- GROUP BY channel
-- ORDER BY 2 DESC;

-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH
	summed_sales AS (
	SELECT s.name AS sales_name, r.name AS region_name, SUM(o.total_amt_usd) AS summed_total_sales
	FROM sales_reps AS s
	JOIN region AS r
	ON r.id = s.region_id
	JOIN accounts AS a
	ON a.sales_rep_id = s.id
	JOIN orders AS o
	ON o.account_id = a.id
	GROUP BY 1,2),

	max_summed_sales AS (
	SELECT region_name, MAX(summed_total_sales) AS max_summed_total
	FROM summed_sales
	GROUP BY 1)

SELECT s.sales_name, m.region_name, m.max_summed_total
FROM max_summed_sales AS m
JOIN summed_sales AS s
ON s.region_name = m.region_name AND s.summed_total_sales = m.max_summed_total
ORDER BY 3 DESC;

-- For the region with the largest sales total_amt_usd, how many total orders were placed?
WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name),
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

-- For the account that purchased the most (in total over their lifetime as a customer) standard_qty paper,
-- how many accounts still had more in total purchases?
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1),
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd,
-- how many web_events did they have for each channel?
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;
