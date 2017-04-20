# Ubuntu 安装Zookeeper 3.4.9

1、解压

tar -zxvf zookeeper-3.4.9.tar.gz -C /opt/program/
ln -s /opt/program/zookeeper-3.4.9 /opt/zookeeper
2、修改配置文件


cd /opt/zookeeper/conf/
cp zoo_sample.cfg zoo.cfg
vi zoo.cfg

dataDir=/opt/zookeeper/zkdata
dataLogDir=/opt/zookeeper/log

server.1=node00:2888:3888
server.2=node01:2888:3888
server.3=node02:2888:3888

3、创建zkdata文件并添加myid

mkdir /opt/zookeeper/zkdata
mkdir /opt/zookeeper/log

cd zkdata
echo 1 > myid
4、scp到其它节点，并修改相应的myid

5、批量启动脚本


#!/bin/bash
for host in node00 node01 node02
do
{
    ssh $host "source /etc/profile;/opt/zookeeper/bin/zkServer.sh "$1
}&wait
done
