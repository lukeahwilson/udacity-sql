-- \i 'C:/Users/lukea/Programming/Udacity Code/udacity-sql/L5_parch_posey.sql'

-- Hypothetical Example
	-- SELECT first_name,
	-- 		last_name,
	-- 		phone_number,
	-- 		LEFT(phone_number, 3) AS area_code,
	-- 		RIGHT(phone_number, 8) AS number_only_1,
	-- 		RIGHT(phone_number, LENGTH(phone_number) - 4) AS number_only_2
	-- FROM customer_data
	-- LIMIT 20;

-- SELECT RIGHT(website, 3), COUNT(*) AS freq_domain_number
-- FROM accounts
-- GROUP BY 1
-- ORDER BY 1 DESC;

-- SELECT LEFT(name, 1), COUNT(*) AS freq_first_letter
-- FROM accounts
-- GROUP BY 1
-- ORDER BY 1 DESC;

-- Proportion of names that start with a letter vs a number
	-- SELECT SUM(letter) AS letters,
	-- 		SUM(number) AS numbers,
	-- 		SUM(number) + SUM(letter) as total,
	-- 		100 * SUM(letter) / (SUM(number) + SUM(letter)) as ratio
	-- FROM (
	-- SELECT name, CASE WHEN LEFT(LOWER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS number,
	-- 			 CASE WHEN LEFT(LOWER(name), 1) IN ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
	-- 		'p','q','r','s','t','u','v','w','x','y','z') THEN 1 ELSE 0 END AS letter
	-- FROM accounts
	-- ) AS one_hot_num_letter_table

-- Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
	-- SELECT 	name,
	-- 		primary_poc,
	-- 		LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name,
	-- 		RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS last_name
	-- FROM accounts
	-- LIMIT 40;

	-- WITH first_dot_last_table AS(
	-- 	SELECT 	name,
	-- 			primary_poc,
	-- 			LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) || '.' ||
	-- 			RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS first_dot_last
	-- 	FROM accounts)
	-- SELECT name, primary_poc, CONCAT(first_dot_last, '@', REPLACE(name, ' ', ''), '.com')
	-- FROM first_dot_last_table
	-- LIMIT 10;
	-- SELECT name, primary_poc, CONCAT(REPLACE(primary_poc, ' ', '.'), '@', REPLACE(name, ' ', ''), '.com')
	-- FROM accounts
	-- LIMIT 10;

-- Demo on using CAST( ) or equivalent :: in order to convert string to DATE
	-- SELECT date AS orig_date, REPLACE(CONCAT(RIGHT(LEFT(date, 10), 4), '/', LEFT(date, 5)), '/', '-')::DATE AS new_date
	-- FROM sf_crime_data
	-- LIMIT 10;

-- Using Coalesce to remove Null values
	-- SELECT 	COUNT(primary_poc) AS regular_count,
	-- 		COUNT(COALESCE(primary_poc, 'NO POC')) AS count_including_no_poc
	-- FROM accounts
	-- LIMIT 10;

	-- SELECT *
	-- FROM accounts a
	-- LEFT JOIN orders o
	-- ON a.id = o.account_id
	-- WHERE o.total IS NULL;

	SELECT COALESCE(o.id, a.id) AS filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
	FROM accounts a
	LEFT JOIN orders o
	ON a.id = o.account_id
	WHERE o.total IS NULL;

	SELECT 	COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
			COALESCE(o.account_id, a.id) account_id, o.occurred_at,
			COALESCE(o.standard_qty, 0) standard_qty,
			COALESCE(o.gloss_qty,0) gloss_qty,
			COALESCE(o.poster_qty,0) poster_qty,
			COALESCE(o.total,0) total,
			COALESCE(o.standard_amt_usd,0) standard_amt_usd,
			COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,
			COALESCE(o.poster_amt_usd,0) poster_amt_usd,
			COALESCE(o.total_amt_usd,0) total_amt_usd
	FROM accounts a
	LEFT JOIN orders o
	ON a.id = o.account_id
	WHERE o.total IS NULL;
