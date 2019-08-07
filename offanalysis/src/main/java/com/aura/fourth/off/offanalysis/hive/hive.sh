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

广告基本信息表 ad_feature

create external table if not exists ad_feature (
    adgroup_id  INT,
    cate_id INT,
    campaign_id INT,
    customer_id INT,
    brand   INT,
    price   DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS PARQUET
LOCATION 'hdfs://hadoopnode:9000/sqoop/ad_feature';


## raw_sample
create external table if not exists raw_sample(
    user_id INT,
    adgroup_id  INT,
    time_stamp  DOUBLE,
    pid INT,
    noclk   TINYINT,
    clk TINYINT
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as parquet
location '/bidb/raw_sample_parquet';


create external table if not exists raw_sample(
    user_id INT,
    adgroup_id  INT,
    time_stamp  DOUBLE,
    pid INT,
    noclk   TINYINT,
    clk TINYINT
)
row format serde
'org.apache.hadoop.hive.serde2.OpenCSVSerde'
with
SERDEPROPERTIES
("separatorChar"=",","quotechar"="\"")
STORED AS TEXTFILE;
## location 'hdfs://hadoopnode:9000/bidb/raw_sample.csv';
load data local inpath '/bigdata/data/raw_sample.csv' overwrite into table raw_sample;

create external table if not exists raw_sample_orc(
    user_id INT,
    adgroup_id  INT,
    time_stamp  DOUBLE,
    pid INT,
    noclk   TINYINT,
    clk TINYINT
)
row format delimited fields terminated by "\t" STORED AS ORC;

insert overwrite table raw_sample_orc select * from raw_sample;


## behavior_log

create external table if not exists behavior_log
(
    user_id    INT,
    time_stamp  DOUBLE,
    btag    STRING,
    cate_id    INT,
    brand   INT
)
row format delimited fields terminated by ','
stored as textfile
location '/bidb/behavior_log';