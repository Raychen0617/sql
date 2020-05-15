create table `stat`(
    `player_id`  int,
    `win`   boolean,
    `iteam1`    smallint,
    `iteam2`    smallint,
    `iteam3`    smallint,
    `iteam4`    smallint,
    `iteam5`    smallint,
    `iteam6`    smallint,
    `kills`   tinyint,
    `death`   tinyint,
    `assists`   tinyint,
    `longesttimespentliving`    smallint,
    `doublekills`   tinyint,
    `triblekills`   tinyint,
    `quadrakills`   tinyint,
    `pentakills`   tinyint,
    `1egendarykilss` tinyint,
    `goldearned`    mediumint, 
    `firstblood`    boolean,
    primary key (`player_id`)

);

load data local infile './stats.csv'
into table `stat`
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;