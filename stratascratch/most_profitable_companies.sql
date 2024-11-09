-- Find the 3 most profitable companies in the entire world.
-- Output the result along with the corresponding company name.
-- Sort the result based on profits in descending order.

-- Table: forbes_global_2010_2014

WITH cte
     AS (SELECT company,
                profits,
                Dense_rank()
                  OVER (
                    ORDER BY profits DESC) AS rnk
         FROM   forbes_global_2010_2014)
SELECT company,
       profits
FROM   cte
WHERE  rnk < 4; 
