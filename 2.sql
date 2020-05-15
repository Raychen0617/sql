SELECT count(distinct SUBSTRING(m.version,1,4)) as cnt
FROM `match_info` as m