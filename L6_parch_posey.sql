-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L6_parch_posey.sql'

	-- SELECT 	standard_qty,
	-- 		SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total
	-- FROM orders
	-- LIMIT 20;

	-- SELECT 	standard_qty,
	-- 		DATE_TRUNC('month', occurred_at) AS month,
	-- 		SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS running_total
	-- FROM orders
	-- LIMIT 40;

	-- Experimental didn't quite get it to work
	-- SELECT 	MAX(running_total), DATE_PART('month', month), DATE_PART('year', month)
	-- FROM ( 	SELECT 	standard_qty,
	-- 				DATE_TRUNC('month', occurred_at) AS month,
	-- 				SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at)) AS running_total
	-- 		FROM orders) AS partitioned
	-- GROUP BY 1,2
	-- ORDER BY 3,2;

	SELECT id,
		standard_amt_usd,
		DATE_TRUNC('year', occurred_at),
		SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total_usd
	FROM orders
	LIMIT 50;
