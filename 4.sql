SELECT m.match_id, CAST((FLOOR(m.duration/3600)*10000 + (FLOOR(m.duration/60)%60*100)+m.duration%60 )as TIME) as `time`
FROM `match_info` as m
ORDER BY m.duration DESC
limit 5