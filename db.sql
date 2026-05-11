Create database DYProjectDB;

CREATE TABLE Product (
    user_id varchar(20),
    product_code VARCHAR(100) PRIMARY KEY,
    product_name VARCHAR(100),
    detail_info VARCHAR(100),
    register_date Date,
    file_name MEDIUMBLOB,
	foreign key (user_id) references Account(user_id) ON UPDATE CASCADE
);

create table Account (
	user_id varchar(20) primary key,
    user_pw varchar(20)
);