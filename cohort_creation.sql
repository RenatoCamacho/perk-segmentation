-- Creating the cohort_temp table
WITH cohort_temp AS (
					SELECT user_id
					FROM sessions
					WHERE session_start >= '2023-01-04'
					GROUP BY user_id
					HAVING COUNT(session_id) > 7
)
-- Main query to extract data for the cohort from sessions table
SELECT s.*
FROM sessions s
JOIN cohort_temp c ON s.user_id = c.user_id
WHERE s.session_start >= '2023-01-04';
;

----joining all 4 tables

WITH cohort AS (
    SELECT user_id
    FROM sessions
    WHERE session_start >= '2023-01-04'
    GROUP BY user_id
    HAVING COUNT(session_id) > 7
)
SELECT * FROM sessions
INNER JOIN cohort USING(user_id)
LEFT JOIN users   USING(user_id)
LEFT JOIN flights USING(trip_id)
LEFT JOIN hotels  USING(trip_id)
WHERE session_start >= '2023-01-04'