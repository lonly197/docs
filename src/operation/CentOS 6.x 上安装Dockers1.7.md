# 在CentOS 6.x 上安装Dockers1.7

> 官方要求，只能运行于64位架构平台，内核版本为2.6.32-431及以上（即>=CentOS 6.5，运行docker时实际提示3.8.0及以上），升级内核请参考《CentOS 6.x 内核升级》
> 
> 需要注意的是CentOS 6.5与7.0的安装是有一点点不同的，CentOS-6上docker的安装包叫docker-io，并且来源于Fedora epel库，这个仓库维护了大量的没有包含在发行版中的软件，所以先要安装EPEL，而CentOS-7的docker直接包含在官方镜像源的Extras仓库（CentOS-Base.repo下的[extras]节enable=1启用）。前提是都需要联网，具体安装过程如下。
> 

<!-- TOC -->

- [在CentOS 6.x 上安装Dockers1.7](#在centos-6x-上安装dockers17)
    - [禁用selinux](#禁用selinux)
    - [安装 Fedora EPEL](#安装-fedora-epel)
    - [检查内核版本](#检查内核版本)
    - [安装 docker-io](#安装-docker-io)
    - [启动试运行](#启动试运行)
    - [配置 Docker 加速器](#配置-docker-加速器)

<!-- /TOC -->

## 禁用selinux
```
# getenforce
enforcing
# setenforce 0
permissive
# vi /etc/selinux/config
SELINUX=disabled
...
```

## 安装 Fedora EPEL
epel-release-6-8.noarch.rpm包在发行版的介质里面已经自带了，可以从rpm安装。
```
# yum install epel-release-6-8.noarch.rpm
//或
# yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# yum update -y
```
> 如果出现GPG key retrieval failed: [Errno 14] Could not open/read file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6问题，请在线安装epel，下载RPM-GPG-KEY-EPEL-6文件。
这一步执行之后，会在/etc/yum.repos.d/下生成epel.repo、epel-testing.repo两个文件，用于从Fedora官网下载rpm包。

## 检查内核版本
```
# uname -r
3.10.105-1.el6.elrepo.x86_64
# cat /etc/redhat-release 
CentOS release 6.8 (Final)
```

## 安装 docker-io
```
# yum install docker-io
Dependencies Resolved

===========================================================================================
 Package                        Arch               Version          Repository     Size
===========================================================================================
Installing:
 docker-io                      x86_64         1.1.2-1.el6          epel          4.5 M
Installing for dependencies:
 lua-alt-getopt                 noarch         0.7.0-1.el6          epel          6.9 k
 lua-filesystem                 x86_64         1.4.2-1.el6          epel           24 k
 lua-lxc                        x86_64         1.0.6-1.el6          epel           15 k
 lxc                            x86_64         1.0.6-1.el6          epel          120 k
 lxc-libs                       x86_64         1.0.6-1.el6          epel          248 k

Transaction Summary
===========================================================================================
Install       6 Package(s)
```

## 启动试运行
```
# service docker start
//或
# docker -d 
```

## 配置 Docker 加速器
```
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://5baf5cd8.m.daocloud.io
```
该脚本可以将 --registry-mirror 加入到你的 Docker 配置文件 /etc/default/docker 中。适用于 Ubuntu14.04、Debian、CentOS6 、CentOS7、Fedora、Arch Linux、openSUSE Leap 42.1，其他版本可能有细微不同。

____
[Support By Lonly](mailto:lonly197@gmail.com)



