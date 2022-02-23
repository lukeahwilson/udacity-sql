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
	SELECT t3.rep_name, t3.region_name, t3.total_amt
	FROM(SELECT region_name, MAX(total_amt) total_amt
	     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
	             FROM sales_reps s
	             JOIN accounts a
	             ON a.sales_rep_id = s.id
	             JOIN orders o
	             ON o.account_id = a.id
	             JOIN region r
	             ON r.id = s.region_id
	             GROUP BY 1, 2) t1
	     GROUP BY 1) t2
	JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
	     FROM sales_reps s
	     JOIN accounts a
	     ON a.sales_rep_id = s.id
	     JOIN orders o
	     ON o.account_id = a.id
	     JOIN region r
	     ON r.id = s.region_id
	     GROUP BY 1,2
	     ORDER BY 3 DESC) t3
	ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

-- What is the lifetime average amount spent in terms of total_amt_usd,
-- including only the companies that spent more per order, on average, than the average of all orders.
	SELECT AVG(avg_amt)
	FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
	    FROM orders o
	    GROUP BY 1
	    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
	                                   FROM orders o)) temp_table;

-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
	SELECT COUNT(*)
	FROM (SELECT a.name
	      FROM orders o
	      JOIN accounts a
	      ON a.id = o.account_id
	      GROUP BY 1
	      HAVING SUM(o.total) > (SELECT total
	                  FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
	                        FROM accounts a
	                        JOIN orders o
	                        ON o.account_id = a.id
	                        GROUP BY 1
	                        ORDER BY 2 DESC
	                        LIMIT 1) inner_tab)
	            ) counter_tab;

-- For the region with the largest sales total_amt_usd, how many total orders were placed?
	SELECT r.name, COUNT(o.total) total_orders
	FROM sales_reps s
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY r.name
	HAVING SUM(o.total_amt_usd) = (
	      SELECT MAX(total_amt)
	      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
	              FROM sales_reps s
	              JOIN accounts a
	              ON a.sales_rep_id = s.id
	              JOIN orders o
	              ON o.account_id = a.id
	              JOIN region r
	              ON r.id = s.region_id
	              GROUP BY r.name) sub);

-- What is the lifetime average amount spent in terms of total_amt_usd,
-- including only the companies that spent more per order, on average, than the average of all orders.
	SELECT AVG(avg_amt)
	FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
	    FROM orders o
	    GROUP BY 1
	    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
	                                   FROM orders o)) temp_table;
