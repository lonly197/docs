# CentOS 6.x python 2.6 升级到 2.7 及 pip 安装

> CentOS 6.X系统默认安装的Python都是2.6版本的，而平时使用以及很多的库都是要求用到2.7版本或以上，所以需要进行python版本升级。
> 

<!-- TOC -->

- [CentOS 6.x python 2.6 升级到 2.7 及 pip 安装](#centos-6-x-python-2-6-2-7-pip)
    - [1、版本查看](#1)
    - [2、依赖安装](#2)
    - [3、升级Python](#3-python)
        - [3.1 安装步骤](#3-1)
        - [3.2 问题](#3-2)
    - [4、安装pip](#4-pip)

<!-- /TOC -->

## 1、版本查看
```
# python -V
Python 2.6.6
```

## 2、依赖安装
```
yum -y update
yum install -y epel-release
yum install -y sqlite-devel
yum install -y zlib-devel.x86_64
yum install -y openssl-devel.x86_64
```

## 3、升级Python

### 3.1 安装步骤

**下载python**
```
wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
```

**解压**
```
unxz Python-2.7.10.tar.xz
tar -vxf Python-2.7.13.tar
```

**进入目录**
```
cd Python-2.7.13
```

**编译安装**
```
./configure --enable-shared --enable-loadable-sqlite-extensions --with-zlib
```
其中--enable-loadable-sqlite-extensions是sqlite的扩展，如果需要使用的话则带上这个选项。

```
vi ./Modules/Setup
```
找到#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz去掉注释并保存，然后进行编译和安装

```
make && make install
```

**备份**
```
mv /usr/bin/python /usr/bin/python2.6.6
```

**创建软连接**
```
ln -s /usr/local/bin/python2.7/python /usr/bin/python
```

**更改yum配置**
```
vim /usr/bin/yum
```
将第一行的#!/usr/bin/python修改成#!/usr/bin/python2.6.6

### 3.2 问题

**1、error while loading shared libraries**

如果我们执行python -V查看版本信息，出现错误“error while loading shared libraries: libpython2.7.so.1.0: cannot open shared object file: No such file or directory”
编辑配置文件
```
vi /etc/ld.so.conf
```
添加新的一行内容/usr/local/bin/python2.7/lib，保存退出，然后
```
/sbin/ldconfig  
/sbin/ldconfig -v
```

## 4、安装pip

下载最新版的pip，然后安装
```
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
```

查找pip的位置
```
whereis pip
```

找到pip2.7的路径，为其创建软链作为系统默认的启动版本
```
ln -s /usr/local/bin/python2.7/pip2.7 /usr/bin/pip
```

至此，pip安装完毕。

[Support By Lonly](mailto:lonly197@gmail.com)