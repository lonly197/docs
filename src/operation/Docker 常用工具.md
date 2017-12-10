# Docker 常用工具

<!-- TOC -->

- [Docker 常用工具](#docker-常用工具)
    - [Watchtower](#watchtower)
    - [docker-gc](#docker-gc)
    - [docker-slim](#docker-slim)
    - [Rocker](#rocker)
    - [ctop](#ctop)

<!-- /TOC -->

## Watchtower

> Watchtower 自动更新Docker容器

Watchtower监视容器运行过程，并且能够捕捉到容器中的变化。当Watchtower检测到有镜像发生变化，会自动使用新镜像重启容器。我在本地开发环境中创建的最后一个镜像就用到了Watchtower。

**使用**

Watchtower本身就像一个Docker镜像，所以它启动容器的方式和别的镜像无异。运行Watchtower的命令如下：

```
docker run -d \
--name watchower \
--rm \
--interval 30 \
-v /var/run/docker.sock:/var/run/docker.sock \
v2tec/watchower
```

上面的代码中，我们用到了一个安装文件/var/run/docker.sock。这个文件主要用来使Watchtower与Docker后台API交互。 interval30秒的选项主要用来定义Watchtower的轮询间隔时间。Watchtower还支持一些别的选项，具体可以查看他们的[文档](http://dwz.cn/65nl1Z)。

默认情况下，Watchtower会轮询Dockder Hub注册表查找更新的镜像。你也可以通过在环境变量REPO_USER和REPO_PASS中添加指定注册表证书，来设置Watchtower轮询私有注册表。

访问地址：[Watchtower](http://dwz.cn/65mKVS)
***

## docker-gc

> 收集垃圾容器和镜像

docker-gc工具能够帮助Docker host清理不需要的容器和镜像。它可以删除存在一小时以上的容器。同时，它也可以删除没有容器的镜像。

**使用**

docker-gc可以被当做脚本，也可以被视为容器。我们用容器方法运行docker-gc，用它来查找可以被删除的容器和镜像。

```
docker run \
--rm \
-e DRY_RUN=1 \
-v /var/run/docker.sock:/var/run/docker.sock \
spotify/docker-gc
```
在上述命令中，我们安装Docker socket文件，这样docker-gc就可以和Docker API进行交互。设置环境变量DRY_RUN=1，查找可被删除的容器和镜像。如果我们不这样设置，docker-gc直接删除它们。所以在删除之前，还是先确认一下。以上代码的输出结果如下：

![](https://raw.githubusercontent.com/lonly197/docs/87e6cec00b54635eafdd993aace825c1bab04dd6/static/img/docker-gc_00.jpg)

确认需要删除的容器和镜像之后，再次运行docker-gc来进行删除清理，这次就不用再设置DRY_RUN参数了。

```
docker run --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
spotify/docker-gc
```

上述命令运行后的输出会告诉你哪些容器和镜像已经被docker-gc删除。
了解更多docker-gc支持的选项，我推荐阅读docker-gc documentation（http://dwz.cn/65nnWn）。

访问地址：[docker-gc](http://dwz.cn/65mKVS)
***

## docker-slim

> docker-slim工具可以通过静态和动态分析，针对你的“胖镜像”创建对应的“瘦镜像”。

**安装**

在[GitHub](http://dwz.cn/65nobo)上下载二进制文件，即可使用docker-slim。该二进制文件在Linux和Mac可用。下载之后添加到路径PATH。

**使用**

docker-slim工具先是对“胖镜像”进行一系列的检测，最终创建了对应的“瘦镜像”。

```
docker-slim build --http-probe hello-world
```

docker-slim对Java、Python、Ruby和Node.js应用都非常友好。

访问地址：[docker-slim](https://github.com/docker-slim/docker-slim)
***

## Rocker

> 打破Dockerfile限制

Rocker给Dockerfile的指令集增加了新的指令。Rocker是由Grammaryly创建的，原意是用来解决Dockerfile格式的问题。

Rocker主要为了解决两个关键问题是：

- Docker镜像的大小
- 构建速度缓慢

**安装**

对于Mac用户，可以用brew安装：

```
brew tap grammarly/tap
brew install grammarly/tap/rocker
```

**使用**

Rocker添加的一些新指令。

- MOUNT用来分享volume，这样依赖管理工具就可以重用。
- FROM指令在Dockerfile中也存在。Rocker添加了不止一条FROM指令。这就意味着，一个Rockerfile可以通过创建多个镜像。首个指令集使用所有依赖来创建artifact，第二个指令集可以使用已有的artifact。这种做法极大的降低了镜像的大小。
- TAG用来标记处于不同构建阶段的镜像。这样一来就不在需要手动标记镜像了。
- PUSH用来把镜像push到registry。
- ATTACH用来和中间步骤交互，在debug的时候非常有用。

```docker
RROM python:2.7-slim
WORKDIR /app
ADD . /app
RUN pip install -r requirmeents.txt
EXPOSE 80
ENV NAME Hello-World
CMD ["python","app.py"]
TAG lonly/hello-world{{ .VERSION }}
PUSH lonly/hello-world{{ .VERSION }}
```

创建镜像并将其push到Docker Hub，可以用下面这条命令：

```
rocker build --push -var VERSION=1.0
```

访问地址：[docker-slim](http://t.cn/RSYSNYp)
***

## ctop

> 容器的顶层界面工具，它可以为多个容器提供实时显示的数据视图

**安装**

```
brew install ctop
```

**使用**

安装之后，只需配置DOCKER_HOST环境变量，即可使用ctop。

```
# 查看所有容器的状态
ctop

# 仅查看当前运行的容器状态
ctop -a
```

访问地址：[ctop](http://t.cn/RSYSQuS)
***

[Support By Lonly](mailto:lonly197@gmail.com)