drop table if exists customer;

CREATE TABLE `customer`
(
    `id`     int NOT NULL AUTO_INCREMENT,
    `f_name` varchar(255) DEFAULT NULL,
    `l_name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
);



