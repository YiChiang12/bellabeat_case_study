-- For Exploratory Analysis

-- 1. Average steps, calories, and sleep time per user
SELECT id,
       AVG(total_steps) AS avg_steps,
       AVG(calories) AS avg_calories,
       AVG(total_minutes_asleep) AS avg_sleep
FROM merged_activity_sleep
GROUP BY id;

-- 2. Weekday trends
SELECT DATENAME(weekday, date) AS weekday,
       AVG(total_steps) AS avg_steps,
       AVG(total_minutes_asleep) AS avg_sleep
FROM merged_activity_sleep
GROUP BY DATENAME(weekday, date);

-- 3. Correlation exploration
SELECT total_steps, calories, total_minutes_asleep
FROM merged_activity_sleep;

-- 4. Device usage classification
SELECT id,
       COUNT(DISTINCT date) AS days_used,
       CASE
           WHEN COUNT(DISTINCT date) >= 21 THEN 'High'
           WHEN COUNT(DISTINCT date) >= 11 THEN 'Moderate'
           ELSE 'Low'
       END AS usage_group
FROM merged_activity_sleep
GROUP BY id;