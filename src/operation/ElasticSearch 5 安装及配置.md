# ElasticSearch5安装及配置

> 确保系统已经安装好jdk1.8.0_73以上，操作系统centos6以上
> 
<!-- TOC -->

- [ElasticSearch5安装及配置](#elasticsearch5)
    - [第一步：下载安装包并安装到指定位置](#)
    - [第二步：修改配置文件](#)
    - [第三步：修改系统参数](#)
    - [第四步：配置ES_HOME](#es_home)
    - [第五步：添加启动用户，设置权限](#)
    - [第六步：启动ES](#es)
    - [第七步：集群部署](#)

<!-- /TOC -->

## 第一步：下载安装包并安装到指定位置
已经将最新版本的安装包放到了/opt/package 目录下，下载是后执行语句：
```
[root@hmly1 ~]# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.tar.gz
[root@hmly1 ~]# tar -zxvf elasticsearch-5.2.0.tar.gz -C /opt/package
```

## 第二步：修改配置文件
修改 /opt/package/elasticsearch-5.2.0/config/elasticsearch.yml
```
# 这里指定的是集群名称，需要修改为对应的，开启了自发现功能后，ES会按照此集群名称进行集群发现
cluster.name: skynet_es_cluster
node.name: skynet_es_cluster_dev1 
# 数据目录
path.data: /cloud/data1/sealion/skynet_es_cluster/data,/cloud/data2/sealion/skynet_es_cluster/data,/cloud/data3/sealion/skynet_es_cluster/data
# log 目录
path.logs: /cloud/data1/sealion/skynet_es_cluster/logs
# 绑定本机内网IP
network.host: 172.18.5.110
http.port: 9205
discovery.zen.ping.unicast.hosts: ["172.18.5.111", "172.18.5.112"]
# discovery.zen.minimum_master_nodes: 3
# enable cors，保证_site类的插件可以访问es
http.cors.enabled: true
http.cors.allow-origin: "*"
# Centos6不支持SecComp，而ES5.2.0默认bootstrap.system_call_filter为true进行检测，所以导致检测失败，失败后直接导致ES不能启动。
bootstrap.memory_lock: false
bootstrap.system_call_filter: false
```

查看系统可用内存：
```
[root@hmly1 ~]# free -g
```

修改/opt/package/elasticsearch-5.2.0/config/jvm.options
```
#  此处设置最小使用内存，常用设置为不超过物理RAM的一半，这里设置为8G
-Xms8g
#  此处设置最大使用内存，常用设置为不超过物理RAM的一半，这里设置为8G
-Xmx8g
```

## 第三步：修改系统参数

> 确保系统有足够资源启动ES

设置内核参数，vi /etc/sysctl.conf
```
# 增加
fs.file-max=65536
vm.max_map_count=655360
```

执行以下命令，确保生效配置生效：
```
[root@hmly1 ~]# sysctl -p
```

设置资源参数，vi /etc/security/limits.conf
```
# 修改
* soft nofile 65536
* hard nofile 131072
* soft nproc 65536
* hard nproc 131072
```

设置用户资源参数，vi /etc/security/limits.d/90-nproc.conf
```
# 增加
sealion    soft    nproc     65536
```

## 第四步：配置ES_HOME
由于es5.0依赖的是jdk8，所以需要下载jdk8并指定PAHT路径
```
[root@hmly1 ~]# export PATH=/opt/package/jdk1.8.0_112/bin:$PATH
[root@hmly1 ~]# export JAVA_HOME=/opt/package/jdk1.8.0_112
[root@hmly1 ~]# export ES_HOME=/opt/package/elasticsearch-5.2.0
```

## 第五步：添加启动用户，设置权限
线上集群默认是用sealion启动es，所以在启动前，需要创建sealion用户和用户组，并修改文件及目录权限
```
[root@hmly1 ~]# groupadd sealion && useradd sealion -g sealion -d /home/sealion && passwd sealion
New password: datatub
[root@hmly1 ~]# mkdir -p /cloud/data{1,2,3}/sealion/skynet_es_cluster/data
[root@hmly1 ~]# mkdir -p /cloud/data1/sealion/skynet_es_cluster/logs
[root@hmly1 ~]# chown sealion. -R /opt/package/elasticsearch-5.2.0
[root@hmly1 ~]# chown sealion. -R /cloud/data{1,2,3}/sealion/skynet_es_cluster/
```

## 第六步：启动ES
使用sealion用户启动elasticsearch服务
```
[root@hmly1 ~]# su -c "cd /opt/package/elasticsearch-5.2.0/bin; ./elasticsearch -d" sealion
```

检查elasticsearch服务
```
[root@hmly1 ~]# ps aux | grep elasticsearch
[root@hmly1 ~]# curl http://172.18.5.110:9200/
```

## 第七步：集群部署
复制elasticsearch-5.2.0到其它机器，修改相应的node.name、network.host以及discovery.zen.ping.unicast.hosts，
```
[root@hmly1 package]# scp -r elasticsearch-5.2.0 root@172.18.5.111:/opt/package/
```
其它步骤同上。

[Support By Lonly](mailto:lonly197@gmail.com)