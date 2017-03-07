# Linux环境JDK1.8安装及配置

### 第一步：检查JDK环境
检索系统已安装的任务版本JDK组件：
```
[root@hmly1 ~]# rpm -qa | grep -E '^open[jre|jdk]|j[re|dk]'
```
查看已安装的JAVA版本：
```
[root@hmly1 ~]# java -version
```
若之前已经安装了JAVA1.6或1.7的版本，请执行下列命令，将他们卸载。
```
[root@hmly1 ~]# yum remove java-1.6.0-openjdk
[root@hmly1 ~]# yum remove java-1.7.0-openjdk
```
-------------
### 第二步：检查系统环境
查看linux版本：
```
[root@hmly1 ~]# lsb_release -a
```
查看系统位数：
```
[root@hmly1 ~]# file /bin/ls
```
-------------
### 第三步：下载安装包并安装到指定位置
根据系统版本系统到Oracle官网下载对应版本的jdk，并将安装包放到了/opt/package 目录下：
```
[root@hmly1 ~]# wget http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz?AuthParam=1486620766_8258d35de303cc0c1ee38d51f1ab68f5
[root@hmly1 ~]# tar -zxvf jdk-8u121-linux-x64.tar.gz -C /opt/package
```
-------------
### 第四步：配置环境变量
打开/etc/profile（vim /etc/profile）
在最后面添加如下内容：
```
JAVA_HOME=/opt/package/jdk1.8.0_112
CLASSPATH=.:$JAVA_HOME/lib.tools.jar
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME CLASSPATH PATH
```
并把将环境变量加到全局中
```
[root@hmly1 ~]# source /etc/profile
```
-------------
### 第五步：验证是否安装成功
```
[root@hmly1 ~]# java -version
```

### Support By Lonly