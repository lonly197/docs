# CentOS 7 设置 ulimit 资源限制

在bash中有个ulimit命令，可以设置当前session的可用资源。包括打开文件描述符数量、用户的最大进程数量、文件大小等。该命令只能临时改变可用资源。

centos7永久改变可用资源有两个地方要设置，/etc/security/limit.conf 和 /etc/security/limit.d/20-nproc.conf 文件，第二个文件是centos7新增加的，用来配置用户最大进程数量，里面的配置会覆盖 limit.conf 文件的配置。

例如，我要配置tomcat用户的 打开文件描述符数量(nofile) 和  用户最大进程数量(nproc)

1. 新建 /etc/security/limit.d/tomcat.conf ，添加以下内容
```
tomcat  soft  nproc   40960
tomcat  hard  nproc   40960
tomcat  soft  nofile  65535
tomcat  hard  nofile  65535
```

2. 重启系统，登录到 tomcat 用户，使用 ulimit -a 命令查看配置是否生效