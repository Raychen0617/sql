
/*

SELECT ch.champion_name
FROM
    (
                        SELECT distinct(p.champion_id)
                        FROM `participant` as p,
                            (
                                SELECT match_id
                                FROM `match`
                                WHERE SUBSTRING(version,1,3) like '7.7'
                            )as m
                        WHERE p.match_id = m.match_id        
    )as c,
    `champ` as ch
WHERE c.champion_id NOT IN
                        (
                        SELECT distinct(champion_id)
                        FROM `teamban` as t,
                            (
                                SELECT match_id
                                FROM `match`
                                WHERE SUBSTRING(version,1,3) like '7.7'
                            )as m
                        WHERE t.match_id = m.match_id
                        )
AND ch.champion_id = c.champion_id
ORDER BY ch.champion_name 

*/


SELECT champion_name
FROM `champ`
WHERE champion_id NOT IN
                        (
                        SELECT distinct(champion_id)
                        FROM `teamban` as t,
                            (
                                SELECT match_id
                                FROM `match_info`
                                WHERE SUBSTRING(version,1,3) like '7.7'
                            )as m
                        WHERE t.match_id = m.match_id
                        )
ORDER BY champion_name

