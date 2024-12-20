/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

-- contest_id, hacker_id, name, sum(total_submissions), sum(total_accepted_submissions), sum(total_views), sum(total_unique_views)

-- with views_cte as (select challenge_id, sum(total_views) as total_vws, sum(total_unique_views) as total_unq_vws from view_stats group by challenge_id), submission_cte as (select challenge_id, sum(total_submissions) as tot_subs, sum(total_accepted_submissions) as tot_acc_subs from submission_stats group by challenge_id), contest_cte as (select CASE WHEN c.contest_id IS NULL THEN ch.challenge_id ELSE c.contest_id END AS contest_id, c.hacker_id, c.name, ch.challenge_id from contests c left join colleges co on c.contest_id = co.college_id inner join challenges ch on ch.college_id = co.college_id) select c.contest_id, c.hacker_id, c.name, sc.tot_subs, sc.tot_acc_subs, vc.total_vws, vc.total_unq_vws from contest_cte c inner join views_cte as vc on c.challenge_id = vc.challenge_id inner join submission_cte as sc on sc.challenge_id = c.challenge_id;

with views_cte as
(select challenge_id, sum(total_views) as total_vws, sum(total_unique_views) as total_unq_vws from view_stats group by challenge_id),
submission_cte as
(select challenge_id, sum(total_submissions) as tot_subs, sum(total_accepted_submissions) as tot_acc_subs from submission_stats group by challenge_id),
contest_cte as
(select CASE WHEN c.contest_id IS NULL THEN ch.challenge_id ELSE c.contest_id END AS contest_id, c.hacker_id, c.name, ch.challenge_id from contests c left join colleges co on c.contest_id = co.college_id inner join challenges ch on ch.college_id = co.college_id)
select c.contest_id, c.hacker_id, c.name, ISNULL(SUM(sc.tot_subs),0), ISNULL(SUM(sc.tot_acc_subs),0), ISNULL(SUM(vc.total_vws),0), ISNULL(SUM(vc.total_unq_vws),0) from contest_cte c inner join views_cte as vc on c.challenge_id = vc.challenge_id inner join submission_cte as sc on sc.challenge_id = c.challenge_id group by c.contest_id, c.hacker_id, c.name HAVING SUM(sc.tot_subs) > 0 OR SUM(sc.tot_acc_subs) > 0 OR SUM(vc.total_vws) > 0 OR SUM(vc.total_unq_vws) > 0 order by c.contest_id;

-- WITH
-- views_cte AS (
--     SELECT
--         challenge_id,
--         SUM(total_views) AS total_vws,
--         SUM(total_unique_views) AS total_unq_vws
--     FROM view_stats
--     GROUP BY challenge_id
-- ),
-- submission_cte AS (
--     SELECT
--         challenge_id,
--         SUM(total_submissions) AS tot_subs,
--         SUM(total_accepted_submissions) AS tot_acc_subs
--     FROM submission_stats
--     GROUP BY challenge_id
-- ),
-- contest_cte AS (
--     SELECT
--         CASE
--             WHEN c.contest_id IS NULL THEN ch.challenge_id
--             ELSE c.contest_id
--         END AS contest_id,
--         c.hacker_id,
--         c.name,
--         ch.challenge_id
--     FROM contests c
--     LEFT JOIN colleges co ON c.contest_id = co.college_id
--     INNER JOIN challenges ch ON ch.college_id = co.college_id
-- )
-- SELECT
--     c.contest_id,
--     c.hacker_id,
--     c.name,
--     sc.tot_subs,
--     sc.tot_acc_subs,
--     vc.total_vws,
--     vc.total_unq_vws
-- FROM contest_cte c
-- INNER JOIN views_cte vc ON c.challenge_id = vc.challenge_id
-- INNER JOIN submission_cte sc ON sc.challenge_id = c.challenge_id;
