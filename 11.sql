SELECT (SUM(win)/COUNT(*)) as teleport_ratio
From `stat`
WHERE player_id IN
                (
                SELECT player_id
                From `participant` 
                WHERE ss1 like 'Teleport' or 'Flash'
                AND ss2 like 'Teleport' or 'Flash'
                AND position like 'TOP'
                )

SELECT (SUM(win)/COUNT(*)) as Ignite_ratio
From `stat`
WHERE player_id IN
                (
                SELECT player_id
                From `participant` 
                WHERE ss1 like 'Ignite' or 'Flash'
                AND ss2 like 'Ignite' or 'Flash'
                AND position like 'TOP'
                )
