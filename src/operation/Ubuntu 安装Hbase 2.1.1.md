# Ubuntu 安装Hbase 2.1.1

## 1、解压

```
tar -zxvf hbase-1.3.0-bin.tar.gz -C /opt/program
ln -s /opt/program/hbase-1.3.0 /opt/hbase
```

## 2、修改配置文件

```
cd /opt/hbase/conf/
```

### (1)、hbase-env.sh

```
vi hbase-env.sh
```
```
export JAVA_HOME=/opt/java
//告诉hbase使用外部的zk
export HBASE_MANAGES_ZK=false
```

### (2)、hbase-site.xml

```
vi hbase-site.xml
```

```XML
<configuration>
    <!-- 指定hbase在HDFS上存储的路径 -->
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://node00:9000/hbase</value>
    </property>
    <!-- 指定hbase是分布式的 -->
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
    <!-- 指定zk的地址，多个用“,”分割 -->
    <property>
        <name>hbase.zookeeper.quorum</name>
        <value>node00:2181,node01:2181,node02:2181</value>
    </property>
</configuration>
```

### (3)、regionservers

```
vi regionservers
```

```
node01
node02
```

## 3、启动集群

```
//启动zookeeper
zkServer.sh start

//启动hdfs
start-dfs.sh

//启动hbase
start-hbase.sh

//管理页面
master:16010
```

____
[Support By Lonly](mailto:lonly197@gmail.com)