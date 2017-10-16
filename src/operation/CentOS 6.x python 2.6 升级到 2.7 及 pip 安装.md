# CentOS 6.x python 2.6 升级到 2.7 及 pip 安装

> CentOS 6.X系统默认安装的Python都是2.6版本的，而平时使用以及很多的库都是要求用到2.7版本或以上，所以需要进行python版本升级。
> 

<!-- TOC -->

- [CentOS 6.x python 2.6 升级到 2.7 及 pip 安装](#centos-6x-python-26-升级到-27-及-pip-安装)
    - [1、版本查看](#1版本查看)
    - [2、依赖安装](#2依赖安装)
    - [3、升级Python](#3升级python)
        - [3.1 安装步骤](#31-安装步骤)
        - [3.2 问题](#32-问题)
    - [4、安装pip](#4安装pip)

<!-- /TOC -->

## 1、版本查看
```
# python -V
Python 2.6.6
```

## 2、依赖安装
```
yum -y update
yum groupinstall "Development tools" -y
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel epel-release zlib-devel.x86_64 openssl-devel.x86_64 readline-devel.x86_64
```

## 3、升级Python

### 3.1 安装步骤

**下载python**
```
cd /opt/package/

wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
```

**解压**
```
tar -xf Python-2.7.13.tar.xz
```

**编译安装**
```
cd Python-2.7.13

./configure  --prefix=/usr/local --enable-shared --enable-loadable-sqlite-extensions --enable-optimizations --with-zlib
```
* --prefix 设定安装位置
* --enable-loadable-sqlite-extensions 是sqlite的扩展
* --with-zlib 
* --enable-shared

> 若需要开启zlib功能，则需要vim ./Modules/Setup，找到#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz，去掉注释并保存，然后进行编译和安装。

```
make && make altinstall
```

**检查**
```
ls -ltr /usr/bin/python*
echo $PATH
```

**备份**
```
mv /usr/bin/python /usr/bin/python2.6.6
```

**创建软连接**
```
ln -s /usr/local/bin/python2.7 /usr/bin/python
```

**更改yum配置**
```
vim /usr/bin/yum
```
将第一行的#!/usr/bin/python修改成#!/usr/bin/python2.6.6

```
vim /suer/bin/yum-config-manager
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
```SHELL
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
```

查找pip的位置
```
whereis pip
```

找到pip2.7的路径，为其创建软链作为系统默认的启动版本
```SHELL
ln -s /usr/local/bin/pip2.7 /usr/bin/pip
```

至此，pip安装完毕。

[Support By Lonly](mailto:lonly197@gmail.com)