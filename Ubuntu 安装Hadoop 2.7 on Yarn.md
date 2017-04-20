# Ubuntu 安装Hadoop 2.7 on Yarn

> Ubuntu版本：14.14
> Hadoop 2.7
> 

## Java 安装
具体可参考 [Linux 环境 JDK 1.8 安装及配置](https://github.com/lonly197/docs/blob/master/Linux%20%E7%8E%AF%E5%A2%83%20JDK%201.8%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md)


## 添加Hadoop User
```
# sudo addgroup hadoop
# sudo adduser --ingroup hadoop hadoop
# sudo adduser hadoop sudo
```

## 安装SSH
```
# sudo apt-get install ssh
# sudo apt-get install rsync
```

检查是否安装正确：
```
# which ssh
# which sshd
```

## 创建并设置SSH认证
```
# su hadoop
# ssh-keygen -t rsa -p "" -f ~/.ssh/id_rsa
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# chmod 0600 ~/.ssh/authorized_keys
```

检查时候配置正确：
```
# ssh localhost
```

## 安装Hadoop

### 下载
```
# cd /opt/packages
# wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
# tar xvzf hadoop-2.7.3.tar.gz
# ln -sf hadoop-2.7.3 /opt/hadoop
```

### 配置

**配置~/.bashrc**
查询Java安装路径
```
# whereis java
```
编辑.bashrc
```
# vim ~/.bashrc
```
根据实质情况设定JAVA_HOME和HADOOP_HOME
```XML
#HADOOP VARIABLES START
export JAVA_HOME=/opt/jdk
export HADOOP_INSTALL=/opt/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
#HADOOP VARIABLES END
```
生效修改
```
# source ~/.bashrc
```

**配置hadoop-env.sh**
编辑hadoop-env.sh
```
# vim /opt/hadoop/etc/hadoop/hadoop-env.sh
```
修改JAVA_HOME配置
```XML
export JAVA_HOME=/opt/jdk
```

**配置core-site.xml**
编辑core-site.xml
```
# mkdir -p ~/tmp
# vim /opt/hadoop/etc/hadoop/core-site.xml
```
在_<configuration>_里加入tmp和fs配置
```XML
<configuration>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/hadoop/tmp</value>
        <description>A base for other temporary directories.</description>
    </property>

    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
        <description>The name of the default file system.  A URI whose
        scheme and authority determine the FileSystem implementation.  The
        uri's scheme determines the config property (fs.SCHEME.impl) naming
        the FileSystem implementation class.  The uri's authority is used to
        determine the host, port, etc. for a filesystem.</description>
    </property>
</configuration>
```

**配置mapred-site.xml.template**
复制mapred-site.xml
```
# cp /opt/hadoop/etc/hadoop/mapred-site.xml.template /opt/hadoop/etc/hadoop/mapred-site.xml
```
编辑mapred-site.xml
```XML
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

**配置yarn-site.xml**
编辑yarn-site.xml
```XML
<configuration>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>localhost</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```

**配置hdfs-site.xml**
编辑hdfs-site.xml
```XML
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.permissions</name>
        <value>false</value>
    </property>
    <property>
        <name>dfs.secondary.http.address</name>
        <value>localhost:50090</value>
    </property>
</configuration>
```

### 启动
```
# hdfs namenode -format
# start-all.sh
```

### 测试
打开WebUI
```
http://localhost:50070/
```
运行example程序
```
# /opt/hadoop/bin/hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar pi 5 10
```

### 停止
```
# stop-all.sh
```

[Support By Lonly](mailto:lonly197@gmail.com)