create table champ(
    
    table_name varchar(30),   
    attribute_name varchar(25),
    attribute_type varchar(25),
    primary_key BOOLEAN,
    foreign_key varchar(25),
    null_  BOOLEAN,
    primary key (table_name)
);

load data local infile './champs.csv'
into table champ
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './matches.csv'
into table champ
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


