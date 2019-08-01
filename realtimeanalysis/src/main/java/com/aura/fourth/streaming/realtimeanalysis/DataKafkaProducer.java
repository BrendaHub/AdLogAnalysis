package com.aura.fourth.streaming.realtimeanalysis;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import java.util.Properties;

public class DataKafkaProducer {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("useage: DataKafkaProducer datapath [intervalMS] [kafkahost:port]");
            return;
        }

        String hdfspath = "hdfs://hadoopcluster:9000/data/behavior_log.cvs";

        // default params
        String dataPath = args[0];
        long intervalMS = 1;
        String hostKafka = "hadoopcluster:9092";

        if (args.length == 2) {
            intervalMS = Long.parseLong(args[1]);
        }
        if (args.length >= 3) {
            hostKafka = args[2];
        }


        SparkConf conf = new SparkConf()
                .setMaster("local[1]")
                .setAppName("sparkKafkaProducer");
        JavaSparkContext jsc = new JavaSparkContext(conf);
        jsc.setLogLevel("Error");

        JavaRDD<String> input = jsc.textFile(dataPath, 10);
        final String host = hostKafka;
        final long interval = intervalMS;
        input.filter(s -> !s.startsWith("user")).foreachPartition(it -> {
            Properties props = new Properties();
            props.put("bootstrap.servers", host);
//            props.put("acks", "all");
            props.put("retries", 0);
            props.put("batch.size", 10);
//            props.put("linger.ms", 1);
            props.put("buffer.memory", 33554432);
            props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
            props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
            Producer<String, String> producer = new KafkaProducer<>(props);
            it.forEachRemaining(s -> {
                String[] line = s.split(",");
                producer.send(new ProducerRecord<>("behavior", line[0], s.substring(line[0].length() + 1)));
                try {
                    Thread.sleep(interval);
                }
                catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });

            producer.close();
        });

        jsc.stop();
    }
}
