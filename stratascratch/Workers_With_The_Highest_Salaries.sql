-- You have been asked to find the job titles of the highest-paid employees.
-- Your output should include the highest-paid title or multiple titles with the same salary.

-- Tables: worker, title

SELECT worker_title
FROM   worker w
       INNER JOIN title t
               ON w.worker_id = t.worker_ref_id
WHERE  salary IN (SELECT Max(salary)
                  FROM   worker);
