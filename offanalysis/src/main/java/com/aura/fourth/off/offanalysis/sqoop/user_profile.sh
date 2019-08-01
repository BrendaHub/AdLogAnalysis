#!/bin/sh
#######
##  将user_profile文件导入mysq
###############

 sqoop import --connect jdbc:mysql://192.168.56.9:3306/bidb
 --username root --password rootroot --table u_profile --driver com.mysql.jdbc.Driver
 --m 10 --target-dir /bigdata/data/user_profile


sqoop import
--connect jdbc:mysql://192.168.56.9:3306/bidb \
--username root \
--password rootroot \
--table user_profile \
--target-dir hdfsPeople \
--delete-target-dir \
-m 3


sqoop import
--connect jdbc:mysql://192.168.56.9:3306/bidb \
--username root \
--password rootroot \
--table user_profile \
--columns "name,age" \
--where "age>18" \
--target-dir hdfsPeople \
--delete-target-dir \
-m 3