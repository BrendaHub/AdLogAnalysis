package com.aura.fourth.off.offanalysis.spark.sql;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

/**
 * @ClassName SparkWork
 * @Description TODO
 * @Author brenda
 * @Date 2019-08-05 23:43
 * @Version 1.0
 **/
public class SparkWork {

    public static void main(String[] args) {
        SparkSession spark = SparkSession
                .builder().master("local[2]")
                .appName("AdLogAnalysis")
                .config("spark.some.config.option", "some-value")
                .getOrCreate();

        Dataset<Row> _df = spark.read().csv("hdfs://hadoopnode:9000/bidb/raw_sample.csv");
        _df.write().parquet("hdfs://hadoopnode:9000/bidb/raw_sample_parquet");
//        _df.show();

//        Dataset<Row> df = spark.read().parquet("hdfs://hadoopnode:9000/bidb/parquet");

//        long count =  df.count();
//        System.out.println("count = " + count );
//        df.show();
//        df.printSchema();

        //Dataset<Row> df_parquet = spark.read().parquet("hdfs://hadoopnode:9000/bidb/parquet");

//        df_parquet.show();
//        df_parquet.take(20);
//        df_parquet.printSchema();
        spark.stop();
    }
}
