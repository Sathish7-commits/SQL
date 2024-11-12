-- Find the first 50% records of the dataset.
-- Table: worker

-- worker_id:int
-- first_name:varchar
-- last_name:varchar
-- salary:int
-- joining_date:datetime
-- department:varchar

WITH row_cte
     AS (SELECT *,
                Row_number()
                  OVER (
                    ORDER BY worker_id) AS row_count
         FROM   worker),
     cte_50_pct
     AS (SELECT Round(Count(*) / 2) AS half_rows
         FROM   worker)
SELECT worker_id,
       first_name,
       last_name,
       salary,
       joining_date,
       department
FROM   row_cte
WHERE  row_count <= (SELECT half_rows
                     FROM   cte_50_pct); 
