create table participant(
    `player_id` int NOT NULL,
    `match_id` int NOT NULL,
    `player`    tinyint,
    `champion_id`   int NOT NULL,
    `ss1` varchar(15),
    `ss2` varchar(15),
    `position`  varchar(13) NOT NULL,
    primary key (player_id),
    foreign key (match_id) references `match_info`(match_id)
);


load data local infile './participants.csv'
into table `participant`
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;