## 配置SQOOP
##2)任务 2
##利用 Sqoop 将 MySQL 中 user_profile 表和 ad_feature 表导入到 HDFS 中
##
## 需要把user_profile导入到HDFS， 采用sqoop-1.99.7-bin-hadoop200版本完成；
##  step1： 根据generic-jdbc-connector创建mysql的数据库连接；
##  step2： 根据hdfs-connector创建hdfs的数据库连接；
##  step3： 创建job 调用上面创建好的link完成一个作业； create job -f "link1" -t "link2"
##  可以通过update link/job  编辑连接或作业；
##
##   导parquet 成功， 导sequenceText失败； 导txt时也可以成功；
##
##   start job --name mh-2 --synchronous
##     Exception has occurred during processing command
##     Exception: org.apache.sqoop.common.SqoopException Message: GENERIC_HDFS_CONNECTOR_0007:Invalid input/output directory - Unexpected exception
##
##
##  命令：
##  bin/sqoop2-server start/stop
##  sqoop:000> set server --host your.host.com --port 12000 --webapp sqoop
##  # 设置交互的命令行打印更多信息，打印的异常信息更多
##    set option --name verbose --value true
##    # 连接sqoop，其中hadoop1是需要连接的sqoop的主机名
##    set server --host hadoop1 --port 12000--webapp sqoop
##    # 查看连接
##    show version --all
##  ./bin/sqoop2-tool verify  验证配置
##  create link -connector generic-jdbc-connector   创建关系型数据库连接
##  注： Identifier enclose:  这里一定要输入一个空格
##
##  create link -connector hdfs-connector  创建hdfs link
##  start job --name mh-2 --synchronous
#############################
