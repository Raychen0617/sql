SELECT s3.position, c.champion_name, s3.KDA
FROM `champ` as c,
(
SELECT final3.champion_id,final2.position, final2.KDA
FROM
    (
        SELECT final1.position, MAX(final1.KDA) as KDA
        FROM 
            (
                SELECT s2.champion_id, s2.position, ((SUM(s2.kills)+SUM(s2.assists))/SUM(s2.death)) as KDA
                FROM
                (
                    SELECT p.position, s1.kills,s1.assists,s1.death, p.champion_id
                            FROM `participant` as p,
                                (
                                SELECT s.kills,s.assists,s.death,s.player_id
                                FROM `stat` as s
                                )as s1 
                    WHERE p.player_id = s1.player_id
                    AND p.position != 'NONE'
                    AND p.position != 'SOLO'
                    AND p.position != 'DUO'
                ) as s2
                GROUP BY s2.champion_id, s2.position
                ORDER BY KDA DESC
            )as final1
        GROUP BY final1.position
    ) as final2,
    (
        SELECT s2.champion_id, s2.position, ((SUM(s2.kills)+SUM(s2.assists))/SUM(s2.death)) as KDA
        FROM
        (
            SELECT p.position, s1.kills,s1.assists,s1.death, p.champion_id
                    FROM `participant` as p,
                        (
                        SELECT s.kills,s.assists,s.death,s.player_id
                        FROM `stat` as s
                        )as s1 
            WHERE p.player_id = s1.player_id
            AND p.position != 'NONE'
            AND p.position != 'SOLO'
            AND p.position != 'DUO'
        ) as s2
        GROUP BY s2.champion_id, s2.position
        ORDER BY KDA DESC
    )as final3
WHERE final3.KDA = final2.KDA)as s3
WHERE c.champion_id = s3.champion_id
ORDER BY s3.position ASC




























