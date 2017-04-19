# Ubuntu 安装Spark 2.1.0 on Yarn

## 安装Java
具体可参考 [Linux 环境 JDK 1.8 安装及配置](https://github.com/lonly197/docs/blob/master/Linux%20%E7%8E%AF%E5%A2%83%20JDK%201.8%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md)


## 安装Scala
具体可参考 [Ubuntu 安装 Scala](https://github.com/lonly197/docs/blob/master/Ubuntu%20%E5%AE%89%E8%A3%85%20Scala.md)


## 安装Hadoop
具体可参考 [Ubuntu 安装Hadoop 2.7 on Yarn](https://github.com/lonly197/docs/blob/master/Ubuntu%20%E5%AE%89%E8%A3%85Hadoop%202.7%20on%20Yarn.md)


## 安装Spark

### 1、下载解压
```
# cd /opt/packages
# wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
tar -zxvf spark-2.1.0-bin-hadoop2.7.tgz -C /opt/program/
ln -s /opt/program/spark-2.1.0-bin-hadoop2.7 /opt/spark
```

### 2、 修改配置
```
# vim /opt/spark/conf/spark-env.sh
```
在文件底部加上：
```XML
export JAVA_HOME=/opt/java
export SCALA_HOME=/opt/scala
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoo
```

### 3、 复制到其它节点

### 4、 启动
```
# /opt/hadoop/sbin/start-all.sh
```

### 5、 测试
```
/opt/spark/bin/spark-submit \
    --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --deploy-mode client \
    --driver-memory 1g \
    --executor-memory 1g \
    --executor-cores 2 \
    /opt/spark/examples/jars/spark-examples*.jar \
    10
```
求出pi则通过测试。