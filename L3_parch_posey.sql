-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L3_parch_posey.sql'

-- Which account (by name) placed the earliest order?
	-- SELECT a.name, o.occurred_at
	-- FROM accounts a
	-- JOIN orders o
	-- ON a.id = o.account_id
	-- ORDER BY occurred_at
	-- LIMIT 1;

-- Find the total sales in usd for each account.
	-- SELECT a.name, SUM(total_amt_usd) total_sales
	-- FROM orders o
	-- JOIN accounts a
	-- ON a.id = o.account_id
	-- GROUP BY a.name;

-- Via what channel did the most recent (latest) web_event occur,
-- which account was associated with this web_event?
	-- SELECT w.occurred_at, w.channel, a.name
	-- FROM web_events w
	-- JOIN accounts a
	-- ON w.account_id = a.id
	-- ORDER BY w.occurred_at DESC
	-- LIMIT 1;

-- Find the total number of times each type of channel from the web_events was used.
	-- SELECT w.channel, COUNT(*)
	-- FROM web_events w
	-- GROUP BY w.channel

-- Who was the primary contact associated with the earliest web_event?
	-- SELECT a.primary_poc
	-- FROM web_events w
	-- JOIN accounts a
	-- ON a.id = w.account_id
	-- ORDER BY w.occurred_at
	-- LIMIT 1;

-- What was the smallest order placed by each account in terms of total usd.
	-- SELECT a.name, MIN(total_amt_usd) smallest_order
	-- FROM accounts a
	-- JOIN orders o
	-- ON a.id = o.account_id
	-- GROUP BY a.name
	-- ORDER BY smallest_order;

-- Find the number of sales reps in each region.
	-- SELECT r.name, COUNT(*) num_reps
	-- FROM region r
	-- JOIN sales_reps s
	-- ON r.id = s.region_id
	-- GROUP BY r.name
	-- ORDER BY num_reps;

-- For each account, determine the average amount of each type of paper they purchased across their orders.
		-- SELECT a.name, AVG(o.standard_qty) AS avg_s,
		-- 	AVG(o.gloss_qty) AS avg_g,
		-- 	AVG(o.poster_qty) AS avg_p
		-- FROM accounts as a
		-- JOIN orders as o
		-- ON o.account_id = a.id
		-- GROUP BY a.name
		-- ORDER BY a.name
		-- LIMIT 20;

-- Determine the number of times a particular channel was used in the web_events table for each sales rep.
	-- SELECT s.name, w.channel, COUNT(*) AS channel_frequency
	-- FROM web_events AS w
	-- JOIN accounts AS a
	-- ON a.id = w.account_id
	-- JOIN sales_reps AS s
	-- ON s.id = a.sales_rep_id
	-- GROUP BY s.name, w.channel
	-- ORDER BY s.name, channel_frequency
	-- LIMIT 30;

-- Test if there are any accounts associated with more than one region.
	-- SELECT r.name, a.id, COUNT(*) AS num_accounts
	-- FROM region AS r
	-- JOIN sales_reps AS s
	-- ON s.region_id = r.id
	-- JOIN accounts AS a
	-- ON a.sales_rep_id = s.id
	-- GROUP BY r.name, a.id
	-- ORDER BY num_accounts DESC
	-- LIMIT 20;

-- Have any sales reps worked on more than one account?
	-- SELECT s.id, s.name, COUNT(*) num_accounts
	-- FROM accounts a
	-- JOIN sales_reps s
	-- ON s.id = a.sales_rep_id
	-- GROUP BY s.id, s.name
	-- ORDER BY num_accounts;
	--
	-- SELECT COUNT(*)
	-- FROM (SELECT DISTINCT id, name
	-- 	FROM sales_reps) AS distinct_reps;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
	-- SELECT a.name, w.channel, COUNT(*) AS chan_freq
	-- FROM accounts AS a
	-- JOIN web_events AS w
	-- ON w.account_id = a.id
	-- GROUP BY a.name, w.channel
	-- HAVING w.channel = 'facebook' AND COUNT(*) > 6
	-- ORDER BY chan_freq DESC
	-- LIMIT 50;

-- How many accounts spent less than 1,000 usd total across all orders?
	-- SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
	-- FROM accounts a
	-- JOIN orders o
	-- ON a.id = o.account_id
	-- GROUP BY a.id, a.name
	-- HAVING SUM(o.total_amt_usd) < 1000
	-- ORDER BY total_spent;

-- Which month did Parch & Posey have the greatest sales in terms of total dollars?
	-- SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
	-- FROM orders
	-- WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
	-- GROUP BY 1
	-- ORDER BY 2 DESC;

-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
	-- SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
	-- FROM orders o
	-- JOIN accounts a
	-- ON a.id = o.account_id
	-- WHERE a.name = 'Walmart'
	-- GROUP BY 1
	-- ORDER BY 2 DESC
	-- LIMIT 5;

-- Write a query to display for each order, the account ID and the level of the order - ‘Large’ or ’Small’
	-- SELECT account_id, total_amt_usd, CASE WHEN total_amt_usd > 3000 THEN 'Large' ELSE 'Small' END as order_size
	-- FROM orders;

-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders.
	-- SELECT s.name, COUNT(*) num_ords,
	--      CASE WHEN COUNT(*) > 200 THEN 'top'
	--      ELSE 'not' END AS sales_rep_level
	-- FROM orders o
	-- JOIN accounts a
	-- ON o.account_id = a.id
	-- JOIN sales_reps s
	-- ON s.id = a.sales_rep_id
	-- GROUP BY 1
	-- ORDER BY 2 DESC;

-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales.
	SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent,
	     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
	     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
	     ELSE 'low' END AS sales_rep_level
	FROM orders o
	JOIN accounts a
	ON o.account_id = a.id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	GROUP BY s.name
	ORDER BY 3 DESC;
