SELECT c.champion_name as self_champion_name, final.win_ratio, final.SELF_KDA as self_kda, final.avg as self_avg_gold ,e.champion_name as enemy_champ_name,final2.KDA as enemy_kda ,final2.avg as enemy_avg_gold, final.cnt as battle_record
FROM
    (
                SELECT  p5.champion_id,(SUM(s.win)/COUNT(*)) as win_ratio,((SUM(s.kills+s.assists))/NULLIF(SUM(s.death),0)) as SELF_KDA,AVG(s.goldearned) as avg, COUNT(*)as cnt
                FROM `stat` as s,
                    (
                    SELECT p3.cnt, p4.champion_id, p4.match_id, p4.player_id
                    FROM 
                        (
                        SELECT COUNT(*)as cnt, p2.champion_id
                        FROM 
                            (
                                    SELECT p.match_id, p.champion_id
                                    FROM `participant` as p                         
                                    WHERE p.match_id IN
                                                        (
                                                        SELECT p3.match_id
                                                        FROM `participant` as p3
                                                        WHERE p3.champion_id = 58
                                                        AND p3.player<= 5
                                                        AND p3.position like '%TOP%'
                                                        )
                                    AND p.champion_id != 58
                                    AND p.position like '%TOP%'
                                    AND p.player>5

                                    UNION                           
                                    SELECT p1.match_id, p1.champion_id
                                    FROM `participant` as p1
                                    WHERE p1.match_id IN
                                                        (
                                                        SELECT p3.match_id
                                                        FROM `participant` as p3
                                                        WHERE p3.champion_id = 58
                                                        AND p3.position like '%TOP%'
                                                        AND p3.player > 5
                                                        )
                                    AND p1.champion_id != 58
                                    AND p1.position like '%TOP%'
                                    AND p1.player<=5
                                    
                                                             
                            ) as p2
                        GROUP BY p2.champion_id
                        HAVING cnt>100
                        ) as p3,
                        (
                                SELECT p.match_id, p.champion_id, p.player_id
                                FROM `participant` as p
                                WHERE p.match_id IN
                                                    (
                                                    SELECT p3.match_id
                                                    FROM `participant` as p3
                                                    WHERE p3.champion_id = 58
                                                    AND p3.position like '%TOP%'
                                                    AND p3.player > 5
                                                    )
                                AND p.champion_id != 58
                                AND p.position like '%TOP%'
                                AND p.player<=5
                                
                                UNION

                                SELECT p.match_id, p.champion_id, p.player_id
                                FROM `participant` as p                         
                                WHERE p.match_id IN
                                                    (
                                                    SELECT p3.match_id
                                                    FROM `participant` as p3
                                                    WHERE p3.champion_id = 58
                                                    AND p3.position like '%TOP%'
                                                    AND p3.player<= 5
                                                    )
                                AND p.champion_id != 58
                                AND p.position like '%TOP%'
                                AND p.player>5
                        )as p4
                    WHERE p3.champion_id = p4.champion_id
                    ORDER BY p3.champion_id ASC
                    )as p5
                WHERE s.player_id = p5.player_id
                GROUP BY p5.champion_id
                ORDER BY win_ratio DESC
                Limit 5
    )as final,
    (
    SELECT s2.champion_id, ((SUM(s.kills+s.assists))/NULLIF(SUM(s.death),0)) as KDA, AVG(s.goldearned) as avg
    FROM `stat` as s,
        (
        SELECT f.champion_id, p.player_id
        FROM 
            (
            SELECT p4.champion_id, p4.match_id
            FROM 
                (
                SELECT  p5.champion_id,(SUM(s.win)/COUNT(*)) as win_ratio
                FROM `stat` as s,
                    (
                        SELECT p3.cnt, p4.champion_id, p4.match_id, p4.player_id
                        FROM 
                            (
                            SELECT COUNT(*)as cnt, p2.champion_id
                            FROM 
                                (
                                        SELECT p.match_id, p.champion_id
                                        FROM `participant` as p                         
                                        WHERE p.match_id IN
                                                            (
                                                            SELECT p3.match_id
                                                            FROM `participant` as p3
                                                            WHERE p3.champion_id = 58
                                                            AND p3.player<= 5
                                                            AND p3.position like '%TOP%'
                                                            )
                                        AND p.champion_id != 58
                                        AND p.position like '%TOP%'
                                        AND p.player>5

                                        UNION                           
                                        SELECT p1.match_id, p1.champion_id
                                        FROM `participant` as p1
                                        WHERE p1.match_id IN
                                                            (
                                                            SELECT p3.match_id
                                                            FROM `participant` as p3
                                                            WHERE p3.champion_id = 58
                                                            AND p3.position like '%TOP%'
                                                            AND p3.player > 5
                                                            )
                                        AND p1.champion_id != 58
                                        AND p1.position like '%TOP%'
                                        AND p1.player<=5
                                        
                                                                
                                ) as p2
                            GROUP BY p2.champion_id
                            HAVING cnt>100
                            ) as p3,
                            (
                                    SELECT p.match_id, p.champion_id, p.player_id
                                    FROM `participant` as p
                                    WHERE p.match_id IN
                                                        (
                                                        SELECT p3.match_id
                                                        FROM `participant` as p3
                                                        WHERE p3.champion_id = 58
                                                        AND p3.position like '%TOP%'
                                                        AND p3.player > 5
                                                        )
                                    AND p.champion_id != 58
                                    AND p.position like '%TOP%'
                                    AND p.player<=5
                                    
                                    UNION

                                    SELECT p.match_id, p.champion_id, p.player_id
                                    FROM `participant` as p                         
                                    WHERE p.match_id IN
                                                        (
                                                        SELECT p3.match_id
                                                        FROM `participant` as p3
                                                        WHERE p3.champion_id = 58
                                                        AND p3.position like '%TOP%'
                                                        AND p3.player<= 5
                                                        )
                                    AND p.champion_id != 58
                                    AND p.position like '%TOP%'
                                    AND p.player>5
                            )as p4
                        WHERE p3.champion_id = p4.champion_id
                        ORDER BY p3.champion_id ASC
                    )as p5
                WHERE s.player_id = p5.player_id
                GROUP BY p5.champion_id
                ORDER BY win_ratio DESC
                Limit 5
            ) as p3,
            (
                                       SELECT p.match_id, p.champion_id
                                        FROM `participant` as p                         
                                        WHERE p.match_id IN
                                                            (
                                                            SELECT p3.match_id
                                                            FROM `participant` as p3
                                                            WHERE p3.champion_id = 58
                                                            AND p3.player<= 5
                                                            AND p3.position like '%TOP%'
                                                            )
                                        AND p.champion_id != 58
                                        AND p.position like '%TOP%'
                                        AND p.player>5

                                        UNION                           
                                        SELECT p1.match_id, p1.champion_id
                                        FROM `participant` as p1
                                        WHERE p1.match_id IN
                                                            (
                                                            SELECT p3.match_id
                                                            FROM `participant` as p3
                                                            WHERE p3.champion_id = 58
                                                            AND p3.position like '%TOP%'
                                                            AND p3.player > 5
                                                            )
                                        AND p1.champion_id != 58
                                        AND p1.position like '%TOP%'
                                        AND p1.player<=5
            )as p4
            WHERE p3.champion_id = p4.champion_id

            ) as f,
            `participant` as p
            WHERE p.match_id = f.match_id
            AND p.champion_id = 58
            LIMIT 2100
        )as s2
    WHERE s2.player_id = s.player_id
    GROUP BY s2.champion_id
    ) as final2,
    `champ` as c,
    (
    SELECT champion_name
    FROM `champ`
    WHERE champion_id=58
    )as e
WHERE final.champion_id = final2.champion_id
AND c.champion_id = final.champion_id
ORDER BY final.win_ratio DESC



