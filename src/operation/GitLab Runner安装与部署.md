# GitLab Runner安装与部署

> 本次安装针对CentOS系统，GitLab Runner基于Docker executor运行
> 

<!-- TOC -->

- [GitLab Runner安装与部署](#gitlab-runner安装与部署)
    - [1、添加 Runner 安装源](#1添加-runner-安装源)
    - [2、安装gitlab-ci-multi-runner](#2安装gitlab-ci-multi-runner)
    - [3、注册 Runner。](#3注册-runner)
    - [4、添加gitlab-ci.yml文件](#4添加gitlab-ciyml文件)

<!-- /TOC -->

## 1、添加 Runner 安装源
```
# curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.rpm.sh | sudo bash
```

## 2、安装gitlab-ci-multi-runner
```
# sudo yum install gitlab-ci-multi-runner -y
```

## 3、注册 Runner。
获取Token：以管理员身份登录GitLab，进入管理区域，点击侧边栏的Runner，如下图，“注册授权码”后的字符串便是Token。

![img](http://omdis1w10.bkt.clouddn.com/gitlab-ci-runner-token-setting.png)

```
# gitlab-ci-multi-runner register
Running in system-mode.                            
                                                   
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
# 输入gitlab-ci coordinator URL
http://git.sw.com/ci
Please enter the gitlab-ci token for this runner:
# 输入Token
NgwTB6Nc4_LdKhsxQPAG
Please enter the gitlab-ci description for this runner:
# 输入runner的名称
test-runner
Please enter the gitlab-ci tags for this runner (comma separated):
# 输入runner的标签，以区分不同的runner，标签间逗号分隔
test,java
Whether to run untagged builds [true/false]:
[false]: true
Registering runner... succeeded                     runner=NgwTB6Nc
Please enter the executor: docker-ssh+machine, docker-ssh, virtualbox, shell, ssh, docker+machine, kubernetes, docker, parallels:
# 输入runner的执行器
shell
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
```

当注册好 Runner 之后，可以用 sudo gitlab-ci-multi-runner list 命令来查看各个 Runner 的状态：
```
# gitlab-runner list
Listing configured runners                          ConfigFile=/etc/gitlab-runner/config.toml
test-runner                                         Executor=shell Token=eae25e1b92d7c01bb5087255a8d50e URL=http://git.sw.com/
```

## 4、添加gitlab-ci.yml文件
配置好 Runner 之后，我们要做的事情就是在项目根目录中添加 .gitlab-ci.yml 文件了。当我们添加了 .gitlab-ci.yml 文件后，每次提交代码或者合并 MR 都会自动运行构建任务了。
![](http://omdis1w10.bkt.clouddn.com/gitlab-add-yml.png)


____
[Support By Lonly](mailto:lonly197@gmail.com)


