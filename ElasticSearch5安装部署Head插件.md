# ElasticSearch5安装部署Head插件

> 5.0版本的ES中由于不支持site类型的插件了，所以需要打开CROS配置，额外添加配置如下:
```
# enable cors
http.cors.enabled: true
http.cors.allow-origin: "*"
```
>

<!-- TOC -->

- [ElasticSearch5安装部署Head插件](#elasticsearch5-head)
    - [第一步，安装git](#git)
    - [第二步，安装node](#node)
    - [第三步，安装grunt](#grunt)
    - [第四步，修改head源码](#head)
    - [第五步，运行head](#head)

<!-- /TOC -->

## 第一步，安装git
需要从github上面下载代码，因此先要安装git
```
[root@hmly1 ~]# yum -y install git
```

安装完成后，就可以直接下载代码了：
```
[root@hmly1 ~]# git clone git://github.com/mobz/elasticsearch-head.git
```

下载后，修改下777权限（简单粗暴），然后拷贝到es的plugins下面，参考:
```
/ES_HOME/plugins/head/*
```

## 第二步，安装node
由于head插件本质上还是一个nodejs的工程，因此需要安装node，使用npm来安装依赖的包。（npm可以理解为maven）
去官网下载nodejs，https://nodejs.org/en/download/

下载下来的jar包是xz格式的，一般的linux可能不识别，还需要安装xz.
```
[root@hmly1 ~]# yum -y install xz
```

然后解压nodejs的安装包:
```
[root@hmly1 ~]# xz -d node*.tar.xz
[root@hmly1 ~]# tar -xvf node*.tar
```

解压完node的安装文件后，需要配置下环境变量,编辑/etc/profile，添加
```
# set node environment
[root@hmly1 ~]# export NODE_HOME=/usr/elk/node-v6.9.1-linux-x64
[root@hmly1 ~]# export PATH=$PATH:$NODE_HOME/bin
```

别忘记立即执行以下
```
[root@hmly1 ~]# source /etc/profile
```

## 第三步，安装grunt
grunt是一个很方便的构建工具，可以进行打包压缩、测试、执行等等的工作，5.0里的head插件就是通过grunt启动的。因此需要安装一下grunt：
```
[root@hmly1 ~]# npm install grunt-cli
```

安装完成后检查一下：
```
[root@hmly1 ~]# grunt -version
grunt-cli v1.2.0
grunt v0.4.5
```

## 第四步，修改head源码
由于head的代码还是2.6版本的，直接执行有很多限制，比如无法跨机器访问。因此需要用户修改两个地方：
修改服务器监听地址
目录：elasticsearch-5.2.0/plugins/head/Gruntfile.js
```
connect: {
    server: {
        options: {
            port: 9100,
            hostname: '*',
            base: '.',
            keepalive: true
        }
    }
}
```
增加hostname属性，设置为*

修改连接地址：
目录：elasticsearch-5.2.0/plugins/head/_site/app.js

修改head的连接地址:
```
this.base_uri = this.config.base_uri || this.prefs.get("app-base_uri") || "http://localhost:9200";
```
把localhost修改成你es的服务器地址，如:
```
this.base_uri = this.config.base_uri || this.prefs.get("app-base_uri") || "http://172.18.5.110:9200";
```

## 第五步，运行head
首先开启5.x ES。
然后在head目录中，执行npm install 下载以来的包：
```
npm install
``` 
最后，启动nodejs
```
grunt server
```
访问:target:9100
这个时候，访问http://xxx:9100就可以访问head插件了.

[Support By Lonly](mailto:lonly197@gmail.com)