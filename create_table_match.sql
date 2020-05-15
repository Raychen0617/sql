create table `match_info`(
    `match_id` int NOT NULL,
    `duration` int,
    `version` varchar(15),
    primary key (match_id, duration)
);

load data local infile './matches.csv'
into table `match_info`
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

