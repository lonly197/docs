# CentOS 6.x MySQL 5.7 安装与配置

<!-- TOC -->

- [CentOS 6.x MySQL 5.7 安装与配置](#centos-6-x-mysql-5-7)
    - [1、检测系统是否自带安装 mysql](#1-mysql)
    - [2、删除系统自带的 mysql 及其依赖](#2-mysql)
    - [3、给 CentOS 添加 rpm 源，并且选择较新的源](#3-centos-rpm)
    - [4、安装 mysql 服务器](#4-mysql)
    - [5、启动 mysql](#5-mysql)
    - [6、查看 mysql 是否自启动，并且设置开启自启动](#6-mysql)
    - [7、mysql 安全设置](#7-mysql)

<!-- /TOC -->

## 1、检测系统是否自带安装 mysql
```
# yum list installed | grep mysql
```

## 2、删除系统自带的 mysql 及其依赖
```
# yum -y remove mysql-libs.x86_64
```

## 3、给 CentOS 添加 rpm 源，并且选择较新的源
```
# wget dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
# yum localinstall mysql-community-release-el6-5.noarch.rpm
# yum repolist all | grep mysql
# yum-config-manager --disable mysql55-community
# yum-config-manager --disable mysql56-community
# yum-config-manager --enable mysql57-community-dmr
# yum repolist enabled | grep mysql
```

## 4、安装 mysql 服务器
```
# yum install -y mysql-community-server
```

## 5、启动 mysql
```
# service mysqld start
```

## 6、查看 mysql 是否自启动，并且设置开启自启动
```
# chkconfig --list | grep mysqld
# chkconfig mysqld on
```

## 7、mysql 安全设置
```
# mysql_secure_installation
```

[Support By Lonly](mailto:lonly197@gmail.com)