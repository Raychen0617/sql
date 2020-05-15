SELECT p.champion_name, p.ss1, p.ss2, p.position, (SUM(p.win)/COUNT(*))as win_ratio, COUNT(*) as pantakill_cnt
FROM
(    
    
    SELECT c.champion_name, p.player_id, p.win, p.ss1, p.ss2, p.position
    FROM 
    `champ` as c,    
    (   
        SELECT t2.champion_id, t1.player_id, t1.win, t2.ss1, t2.ss2, t2.cnt, t2.position 
        FROM     
        (
            SELECT p.champion_id, p.ss1, p.ss2, p.position, COUNT(*)as cnt
            FROM
            (
                SELECT player_id
                FROM `stat` 
                WHERE pentakills >= 1
            ) as s,
            `participant` as p
            WHERE s.player_id = p.player_id
            GROUP BY p.champion_id, p.ss1, p.ss2 , p.position
            ORDER BY cnt DESC
            limit 10
        ) as t2,
        (
            SELECT p.champion_id, p.position, p.ss1, p.ss2, s.player_id, s.win
            FROM
            (
                SELECT player_id, win
                FROM `stat` 
                WHERE pentakills >= 1
            ) as s,
            `participant` as p
            WHERE s.player_id = p.player_id
        )as t1
        WHERE t1.champion_id = t2.champion_id
        AND t1.ss1 = t2.ss1
        AND t1.ss2 = t2.ss2
        AND t1.position = t2.position

    )as p
    WHERE c.champion_id = p.champion_id
) as p
GROUP BY p.champion_name, p.ss1, p.ss2, p.position
ORDER BY pantakill_cnt DESC








