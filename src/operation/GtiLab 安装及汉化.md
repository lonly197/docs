# GitLab 安装及汉化

> 源码安装 GitLab 步骤繁琐：需要安装依赖包，Mysql，Redis，Postfix，Ruby，Nginx……安装完毕还得一个个手动配置这些软件。源码安装容易出错，不顺利的话，一天都搞不定。源码最大的好处是私人定制，如果不做定制化，还是使用官方推荐的 omnibus packages 方式安装，网络好的话，一个小时内可以搞定。
> 

<!-- TOC -->

- [GitLab 安装及汉化](#gitlab-安装及汉化)
    - [安装](#安装)
        - [1、添加安装源](#1添加安装源)
        - [2、安装依赖包](#2安装依赖包)
        - [3、修改Hosts](#3修改hosts)
    - [汉化](#汉化)
        - [1、安装中文语言包（汉化）](#1安装中文语言包汉化)

<!-- /TOC -->

## 安装

### 1、添加安装源
使用国内镜像安装，新建 /etc/yum.repos.d/gitlab-ce.repo，添加以下内容
```
[gitlab-ce]
name=gitlab-ce
baseurl=http://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el6
repo_gpgcheck=0
gpgcheck=0
enabled=1
gpgkey=https://packages.gitlab.com/gpg.key
```

### 2、安装依赖包
```
# 安装依赖包
sudo yum install curl openssh-server openssh-clients postfix cronie
# 启动 postfix 邮件服务
sudo service postfix start
# 检查 postfix
sudo chkconfig postfix on
# 安装 GitLab 社区版
sudo yum install gitlab-ce
# 初始化 GitLab
sudo gitlab-ctl reconfigure
```

### 3、修改Hosts
添加访问的 hosts，修改/etc/gitlab/gitlab.rb的external_url
```
external_url 'http://git.home.com'
```
vi /etc/hosts，添加 host 映射
```
127.0.0.1 git.home.com
```
每次修改/etc/gitlab/gitlab.rb，都要运行以下命令，让配置生效
```
sudo gitlab-ctl reconfigure
```
配置本机的 host，如：192.168.113.59 git.home.com。最后，在浏览器打开网址http://git.home.com，登陆。默认管理员：
> 用户名: root
> 密码: 5iveL!fe


## 汉化

### 1、安装中文语言包（汉化）
以下汉化步骤参考[此篇文章](https://larryli.cn/2015/07/644905)，首先确认当前安装版本
```
cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
```
当前安装版本是8.8.7，因此中文补丁需要打8.8版本。
克隆 GitLab 源码仓库：
```
# 克隆 GitLab.com 仓库
git clone https://gitlab.com/larryli/gitlab.git
```
运行汉化补丁：
```
# 8.8 版本的汉化补丁（8-8-stable是英文稳定版，8-8-zh是中文版，两个 diff 结果便是汉化补丁）
sudo git diff origin/8-8-stable..8-8-zh > /tmp/8.8.diff
# 停止 gitlab
sudo gitlab-ctl stop
# 应用汉化补丁
cd /opt/gitlab/embedded/service/gitlab-rails
git apply /tmp/8.8.diff  
# 启动gitlab
sudo gitlab-ctl start
```
至此，汉化完毕。打开地址http://git.home.com，便会看到中文版的GitLab。如下
![](http://omdis1w10.bkt.clouddn.com/gitlab-zh.jpg)
安装完成。

____
[Support By Lonly](mailto:lonly197@gmail.com)