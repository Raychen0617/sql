create table champ(
    champion_name varchar(15) NOT NULL,
    champion_id int NOT NULL,
    primary key (champion_id)
);


load data local infile './champs.csv'
into table champ
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


