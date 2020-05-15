
SELECT p8.position, c.champion_name
FROM
    (SELECT p5.champion_id, MAX(p5.cnt) as cnt
    FROM
        (
        SELECT p1.position,p1.champion_id,COUNT(*)as cnt
        FROM `participant` as p1
        WHERE p1.match_id in(SELECT m.match_id
                            FROM `match_info` as m
                            WHERE m.duration BETWEEN 2400 AND 3000)
        GROUP BY p1.champion_id, p1.position
        ORDER BY cnt DESC 
        limit 40
        )as p5
    GROUP BY p5.champion_id
    )as p7,

    (SELECT p6.position, MAX(p6.cnt) as cnt
    FROM
        (
        SELECT p1.position,p1.champion_id,COUNT(*)as cnt
        FROM `participant` as p1
        WHERE p1.match_id in(SELECT m.match_id
                            FROM `match_info` as m
                            WHERE m.duration BETWEEN 2400 AND 3000)
        GROUP BY p1.champion_id, p1.position
        ORDER BY cnt DESC 
        limit 40
        )as p6
    GROUP BY p6.position
    ) as p8,
    `champ` as c 
WHERE p7.cnt = p8.cnt
AND c.champion_id = p7.champion_id
ORDER BY p8.position