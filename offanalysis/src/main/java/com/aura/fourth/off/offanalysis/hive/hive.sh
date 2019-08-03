创建表

用户基本信息表 user_profile

create external table if not exists user_profile(
userid  INT,
cms_segid   BIGINT,
cms_group_id    BIGINT,
final_gender_code   STRING,
age_level   INT,
pvalue_level    STRING,
shopping_level  STRING,
occupation  STRING,
new_user_class_level   INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
lines terminated by '\n'
stored as parquet
location 'hdfs://hadoopnode:9000/sqoop/user_profile_parquet';

## stored as parquet