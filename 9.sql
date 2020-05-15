
SELECT if(SUBSTRING(final.version,4,4) ='.', SUBSTRING(final.version,1,3), SUBSTRING(final.version,1,4)) as  version,  final.win_cnt, final.lose_cnt, final.win_ratio
FROM 
(
    
    SELECT SUBSTRING(m1.version,1,4) as version, (SUM(s.win)/2) as win_cnt, ((COUNT(*) - (SUM(s.win)))/2)as lose_cnt, (SUM(s.win)/COUNT(*)) as win_ratio
    FROM 
    (
        SELECT m.version, u.player_id           
        FROM     
            (
                SELECT p3.match_id, p3.player_id
                FROM 
                (
                    SELECT p1.match_id
                    FROM 
                    (
                        SELECT p.match_id, p.player, p.player_id
                        FROM 
                            (
                            SELECT match_id, player, player_id
                            FROM `participant`
                            WHERE (champion_id = 64 OR champion_id = 17)
                            AND player>5                   /* same team */
                            )as p
                            GROUP BY p.match_id, p.player, p.player_id
                    )as p1
                    GROUP BY p1.match_id
                    HAVING COUNT(*)>1
                )as p2,
                (
                    SELECT p.match_id, p.player, p.player_id
                    FROM 
                        (
                        SELECT match_id, player, player_id
                        FROM `participant`
                        WHERE champion_id = 64
                        OR champion_id = 17
                        )as p
                    GROUP BY p.match_id, p.player, p.player_id
                    )as p3
                WHERE p3.match_id = p2.match_id
            
                UNION
            
                SELECT p3.match_id, p3.player_id
                FROM 
                (
                SELECT p1.match_id
                FROM 
                    (
                        SELECT p.match_id, p.player, p.player_id
                        FROM 
                            (
                            SELECT match_id, player, player_id
                            FROM `participant`
                            WHERE (champion_id = 64 OR champion_id = 17)
                            AND player<=5
                            

                            )as p
                        GROUP BY p.match_id, p.player, p.player_id
                        )as p1
                GROUP BY p1.match_id
                HAVING COUNT(*)>1
                    )as p2,

                    (
                        SELECT p.match_id, p.player, p.player_id
                        FROM 
                            (
                            SELECT match_id, player, player_id
                            FROM `participant`
                            WHERE champion_id = 64
                            OR champion_id = 17
                            )as p
                        GROUP BY p.match_id, p.player, p.player_id
                    )as p3
                WHERE p3.match_id = p2.match_id
            )as u,
            `match_info` as m
        WHERE m.match_id = u.match_id
    )as m1,
    `stat` as s
    WHERE s.player_id = m1.player_id
    GROUP BY SUBSTRING(m1.version,1,4)
)as final
ORDER BY version