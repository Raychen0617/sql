SELECT if(lose.win,'win','lose') win_lose, final.lose_cnt as cnt
FROM
(    
    SELECT COUNT(*) as lose_cnt
    FROM(
        SELECT m1.match_id, AVG(m1.longesttimespentliving)as avg,COUNT(*) as lose_cnt
        FROM(
            SELECT p.match_id, p.player_id, s.longesttimespentliving, s.win
            FROM `stat` as s,
                `participant` as p
            WHERE s.player_id = p.player_id
            AND s.win=0
            ) as m1
        GROUP BY m1.match_id
        HAVING avg>=1200
        ) as final1
) as final,
(
    SELECT win
    FROM stat
    WHERE win=0
    limit 1
)as lose 
UNION
SELECT if(lose.win,'win','lose') win_lose, final.lose_cnt as cnt
FROM
(    
    SELECT COUNT(*) as lose_cnt
    FROM(
        SELECT m1.match_id, AVG(m1.longesttimespentliving)as avg,COUNT(*) as lose_cnt
        FROM(
            SELECT p.match_id, p.player_id, s.longesttimespentliving, s.win
            FROM `stat` as s,
                `participant` as p
            WHERE s.player_id = p.player_id
            AND s.win=1
            ) as m1
        GROUP BY m1.match_id
        HAVING avg>=1200
        ) as final1
) as final,
(
    SELECT win
    FROM stat
    WHERE win=1
    limit 1
)as lose 