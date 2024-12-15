-- A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.

-- Input Format

-- The STATION table is described as follows:
-- ID, CITY, STATE, LAT_N, LONG_N

WITH rn_cte AS
  (SELECT LAT_N,
          ROW_NUMBER() OVER (
                             ORDER BY LAT_N) AS rn
   FROM station),
     median_cte AS
  (SELECT CASE
              WHEN count(1) % 2 = 0 THEN COUNT(1)/2
              ELSE (count(1)+1)/2
          END AS median
   FROM station)
SELECT CAST(ROUND(lat_n,4) AS DECIMAL(20,4))
FROM rn_cte
WHERE rn =
    (SELECT median
     FROM median_cte)
