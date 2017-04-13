# CentOS 6.x/7.x MySQL 5.7 安装与配置

<!-- TOC -->

- [CentOS 6.x/7.x MySQL 5.7 安装与配置](#centos-6x7x-mysql-57-安装与配置)
    - [安装](#安装)
        - [1、检测系统是否自带安装 mysql](#1检测系统是否自带安装-mysql)
        - [2、删除系统自带的 mysql 及其依赖](#2删除系统自带的-mysql-及其依赖)
        - [3、给 CentOS 添加 rpm 源，并且选择较新的源](#3给-centos-添加-rpm-源并且选择较新的源)
        - [4、安装 mysql 服务器](#4安装-mysql-服务器)
        - [5、启动 mysql](#5启动-mysql)
        - [6、查看 mysql 是否自启动，并且设置开启自启动](#6查看-mysql-是否自启动并且设置开启自启动)
        - [7、mysql 安全设置](#7mysql-安全设置)
    - [配置](#配置)
        - [1、新增用户](#1新增用户)
        - [2、用户授权](#2用户授权)
        - [3、删除用户](#3删除用户)
        - [4、修改指定用户密码](#4修改指定用户密码)

<!-- /TOC -->

## 安装

### 1、检测系统是否自带安装 mysql
```
# yum list installed | grep mysql
```

### 2、删除系统自带的 mysql 及其依赖
```
# yum -y remove mysql-libs.x86_64
```

### 3、给 CentOS 添加 rpm 源，并且选择较新的源
```
--------------- On RHEL/CentOS 7 ---------------
# wget http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
# yum localinstall mysql57-community-release-el7-7.noarch.rpm

--------------- On RHEL/CentOS 6 ---------------
# wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
# yum localinstall mysql57-community-release-el6-7.noarch.rpm

# 验证 MySQL Yum Repository
# yum repolist enabled | grep "mysql.*-community.*"
```

### 4、安装 mysql 服务器
```
# yum install -y mysql-community-server
```

### 5、启动 mysql
```
# 启动服务
# service mysqld start

# 查看服务状态
# service mysqld status

# 查看MySQL版本
# mysql --version
```

### 6、查看 mysql 是否自启动，并且设置开启自启动
```
# chkconfig --list | grep mysqld
# chkconfig mysqld on
```

### 7、mysql 安全设置
```
# 查看安装临时密码
# grep 'temporary password' /var/log/mysqld.log

# 安全设置
# 1. 设置新的root密码
# 2. 安装密码验证插件
# 3. 修改密码政策
# 4. 删除匿名用户
# 5. 禁用root远程登陆
# 6. 删除‘test’数据库
# 7. 更新权限
# mysql_secure_installation
```

> 关于安全等级更详细的介绍如下:
>
> **LOW** 政策只测试密码长度。 密码必须至少有8个字符长。
>
> **MEDIUM** 政策的条件 密码必须包含至少1数字字符,1 大写和小写字符,和1特别 (nonalphanumeric)字符。
>
> **STRONG** 政策的情况 密码子字符串长度为4的或更长时间不能匹配 单词在字典文件中,如果一个人被指定。

## 配置

### 1、新增用户
创建test用户，密码是1234。
```
# mysql -u root -p 
# 本地登录 
# create user “test”@”localhost” identified by “1234”; 
# 远程登录 
# create user “test”@”%” identified by “1234”; 
# 退出
# quit 
# 测试是否创建成功
# mysql -utest -p 
```

### 2、用户授权
a.授权格式：grant 权限 on 数据库.* to 用户名@登录主机 identified by “密码”;　

b.登录MYSQL，这里以ROOT身份登录：
```
# mysql -u root -p
```
c.为用户创建一个数据库(testDB)：
```
# create database testDB; 
# create database testDB default charset utf8 collate utf8_general_ci;
```
d.授权test用户拥有testDB数据库的所有权限：
```
# grant all privileges on testDB.* to “test”@”localhost” identified by “1234”; 
# 刷新系统权限表
# flush privileges; 
```
e.指定部分权限给用户:
```
# grant select,update on testDB.* to “test”@”localhost” identified by “1234”; 
# flush privileges; 
```
f.授权test用户拥有所有数据库的某些权限： 　
```
# ”%” 表示对所有非本地主机授权，不包括localhost
# grant select,delete,update,create,drop on . to test@”%” identified by “1234”; 
```

### 3、删除用户
```
# mysql -u root -p 
# Delete FROM mysql.user Where User=”test” and Host=”localhost”; 
# flush privileges; 
# drop database testDB;

# 删除账户及权限：
# drop user 用户名@’%’; 
# drop user 用户名@ localhost;
```

### 4、修改指定用户密码
```
# mysql -u root -p 
# update mysql.user set authentication_string=password(“新密码”) where User=”test” and Host=”localhost”; 
# flush privileges;
```


[Support By Lonly](mailto:lonly197@gmail.com)