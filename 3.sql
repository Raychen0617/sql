SELECT c.champion_name, p1.cnt
FROM (SELECT COUNT(*) as cnt, p.champion_id
    FROM `participant` as p
    WHERE p.position like '%JUNGLE%'
    GROUP BY p.champion_id
    ORDER BY cnt DESC
    limit 3
    )as p1, champ as c   
WHERE c.champion_id = p1.champion_id;