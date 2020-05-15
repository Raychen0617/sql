create table `teamban`(
    `match_id`  int NOT NULL,
    `team` char(1) NOT NULL, 
    `champion_id` int NOT NULL,
    `banturn`   tinyint NOT NULL,
    primary key (match_id, banturn)
);


load data local infile './teambans.csv'
into table `teamban`
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;