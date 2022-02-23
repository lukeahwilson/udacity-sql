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
