# Ubuntu 安装 Scala

<!-- TOC -->

- [Ubuntu 安装 Scala](#ubuntu-安装-scala)
- [1、下载scala压缩包](#1下载scala压缩包)
- [2、建立目录，解压文件到所建立目录](#2建立目录解压文件到所建立目录)
- [3、添加环境变量](#3添加环境变量)
- [4、测试，观察结果版本号是否一致](#4测试观察结果版本号是否一致)

<!-- /TOC -->

# 1、下载scala压缩包
```
http://www.scala-lang.org/download/
```

# 2、建立目录，解压文件到所建立目录
```
$ sudo mkdir /opt/scala
$ sudo tar zxvf scala-2.11.11.tgz 
$ sudo mv scala-211.11 /opt/scala
``` 

# 3、添加环境变量
编辑配置文件/etc/profile
```
$ vim /etc/profile
```
在文件的结尾添加如下：
```XML
# SCALA_HOME
SCALA_HOME=/opt/scala
PATH=$SCALA_HOME/bin:$PATH
export SCALA_HOME PATH
```
生效配置：
```
$ source /etc/profile
```

# 4、测试，观察结果版本号是否一致
```
$ scala -version
Scala code runner version 2.11.11 -- Copyright 2002-2017, LAMP/EPFL
```


____
[Support By Lonly](mailto:lonly197@gmail.com)