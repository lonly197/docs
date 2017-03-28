# GitLab CI 进行持续集成

> 从 GitLab 8.0 开始，GitLab CI 就已经集成在 GitLab 中，我们只要在项目中添加一个 .gitlab-ci.yml 文件，然后添加一个 Runner，即可进行持续集成。 而且随着 GitLab 的升级，GitLab CI 变得越来越强大，本文将介绍如何使用 GitLab CI 进行持续集成。
> 

<!-- TOC -->

- [GitLab CI 进行持续集成](#gitlab-ci)
    - [基本概念](#)
        - [Pipeline](#pipeline)
        - [Stages](#stages)
        - [Jobs](#jobs)
    - [GitLab Runner](#gitlab-runner)
        - [Runner类型](#runner)
            - [Shared Runner](#shared-runner)
            - [Specific Runner](#specific-runner)
        - [安装](#)
        - [注册 Runner](#runner)
    - [.gitlab-ci.yml](#gitlab-ci-yml)
        - [简介](#)
        - [基本写法](#)
        - [常用的关键字](#)
            - [stages](#stages)
            - [types](#types)
            - [before_script](#before_script)
            - [after_script](#after_script)
            - [variables && Job.variables](#variables-job-variables)
            - [cache && Job.cache](#cache-job-cache)
            - [Job.script](#job-script)
            - [Job.stage](#job-stage)
            - [Job.artifacts](#job-artifacts)
        - [实用例子](#)
            - [前端的 Gitlab CI 例子](#gitlab-ci)
            - [后端的 Gitlab CI 例子](#gitlab-ci)
    - [常见问题](#)
        - [Permission denied 问题](#permission-denied)
        - [NPM INSTALL 过程慢](#npm-install)
        - [gitlab-runner 删除失败](#gitlab-runner)

<!-- /TOC -->

## 基本概念

### Pipeline
一次 Pipeline 其实相当于一次构建任务，里面可以包含多个流程，如安装依赖、运行测试、编译、部署测试服务器、部署生产服务器等流程。
任何提交或者 Merge Request 的合并都可以触发 Pipeline，如下图所示：
```
+------------------+           +----------------+
|                  |  trigger  |                |
|   Commit / MR    +---------->+    Pipeline    |
|                  |           |                |
+------------------+           +----------------+
```

### Stages
Stages 表示构建阶段，说白了就是上面提到的流程。
我们可以在一次 Pipeline 中定义多个 Stages，这些 Stages 会有以下特点：

* 所有 Stages 会按照顺序运行，即当一个 Stage 完成后，下一个 Stage 才会开始
* 只有当所有 Stages 完成后，该构建任务 (Pipeline) 才会成功
* 如果任何一个 Stage 失败，那么后面的 Stages 不会执行，该构建任务 (Pipeline) 失败

因此，Stages 和 Pipeline 的关系就是：
```
+--------------------------------------------------------+
|                                                        |
|  Pipeline                                              |
|                                                        |
|  +-----------+     +------------+      +------------+  |
|  |  Stage 1  |---->|   Stage 2  |----->|   Stage 3  |  |
|  +-----------+     +------------+      +------------+  |
|                                                        |
+--------------------------------------------------------+
```

### Jobs
Jobs 表示构建工作，表示某个 Stage 里面执行的工作。
我们可以在 Stages 里面定义多个 Jobs，这些 Jobs 会有以下特点：

* 相同 Stage 中的 Jobs 会并行执行
* 相同 Stage 中的 Jobs 都执行成功时，该 Stage 才会成功
* 如果任何一个 Job 失败，那么该 Stage 失败，即该构建任务 (Pipeline) 失败

所以，Jobs 和 Stage 的关系图就是：
```
+------------------------------------------+
|                                          |
|  Stage 1                                 |
|                                          |
|  +---------+  +---------+  +---------+   |
|  |  Job 1  |  |  Job 2  |  |  Job 3  |   |
|  +---------+  +---------+  +---------+   |
|                                          |
+------------------------------------------+
```

## GitLab Runner
一般来说，构建任务都会占用很多的系统资源 (譬如编译代码)，而 GitLab CI 又是 GitLab 的一部分，如果由 GitLab CI 来运行构建任务的话，在执行构建任务的时候，GitLab 的性能会大幅下降。

所以 GitLab Runner 就承担构建的重任，它可以安装到不同的机器上，这样，在构建任务运行期间就不会影响到 GitLab 的性能。

### Runner类型

GitLab-Runner可以分类两种类型：Shared Runner（共享型）和Specific Runner（指定型）。

#### Shared Runner
这种Runner（工人）是所有工程都能够用的。只有系统管理员能够创建Shared Runner。

#### Specific Runner
这种Runner（工人）只能为指定的工程服务。拥有该工程访问权限的人都能够为该工程创建Shared Runner。


>  1. 什么情况下需要注册Shared Runner？
> 比如，GitLab上面所有的工程都有可能需要在公司的服务器上进行编译、测试、部署等工作，这个时候注册一个Shared Runner供所有工程使用就很合适。
>
> 2. 什么情况下需要注册Specific Runner？
> 比如，我可能需要在我个人的电脑或者服务器上自动构建我参与的某个工程，这个时候注册一个Specific Runner就很合适。
>
> 3. 什么情况下需要在同一台机器上注册多个Runner？
> 比如，我是GitLab的普通用户，没有管理员权限，我同时参与多个项目，那我就需要为我的所有项目都注册一个Specific Runner，这个时候就需要在同一台机器上注册多个Runner。


### 安装
具体可参考之前的安装文档，这里给出针对Debian/Ubuntu的安装命令：
```
# For Debian/Ubuntu
$ curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
$ sudo apt-get install gitlab-ci-multi-runner
# For CentOS
$ curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.rpm.sh | sudo bash
$ sudo yum install gitlab-ci-multi-runner
```

### 注册 Runner
安装好 GitLab Runner 之后，我们只要启动 Runner 然后和 CI 绑定就可以了：

* 打开你 GitLab 中的项目页面，在项目设置中找到 runners
* 运行 sudo gitlab-ci-multi-runner register
* 输入 CI URL
* 输入 Token
* 输入 Runner 的名字
* 选择 Runner 的类型，简单起见还是选 Shell 吧
* 完成

当注册好 Runner 之后，可以用 sudo gitlab-ci-multi-runner list 命令来查看各个 Runner 的状态：
```
$ sudo gitlab-runner list
Listing configured runners          ConfigFile=/etc/gitlab-runner/config.toml
my-runner                           Executor=shell Token=cd1cd7cf243afb47094677855aacd3 URL=http://git.sw.com/ci
```

## .gitlab-ci.yml

### 简介
配置好 Runner 之后，需要在项目根目录中添加 .gitlab-ci.yml 文件。
当我们添加了 .gitlab-ci.yml 文件后，每次提交代码或者合并 MR 都会自动运行构建任务了。

.gitlab-ci.yml 就是在定义项目的 Pipeline 。

### 基本写法
一个简单的例子：
```
# 定义 stages
stages:
  - build
  - test
# 定义 job
job1:
  stage: test
  script:
    - echo "I am job1"
    - echo "I am in test stage"
# 定义 job
job2:
  stage: build
  script:
    - echo "I am job2"
    - echo "I am in build stage"
```

用 stages 关键字来定义 Pipeline 中的各个构建阶段，然后用一些非关键字来定义 jobs。

每个 job 中可以可以再用 stage 关键字来指定该 job 对应哪个 stage。

job 里面的 script 关键字是最关键的地方，也是每个 job 中必须要包含的，它表示每个 job 要执行的命令。

### 常用的关键字
面介绍一些常用的关键字，想要更加详尽的内容请前往 [官方文档](http://docs.gitlab.com/ce/ci/yaml/README.html)

#### stages
定义 Stages，默认有三个 Stages，分别是 build, test, deploy。

#### types
stages 的别名。

#### before_script
定义任何 Jobs 运行前都会执行的命令。

#### after_script
> 要求 GitLab 8.7+ 和 GitLab Runner 1.2+
定义任何 Jobs 运行完后都会执行的命令。

#### variables && Job.variables
> 要求 GitLab Runner 0.5.0+
定义环境变量。
如果定义了 Job 级别的环境变量的话，该 Job 会优先使用 Job 级别的环境变量。

#### cache && Job.cache
> 要求 GitLab Runner 0.7.0+
定义需要缓存的文件。

每个 Job 开始的时候，Runner 都会删掉 .gitignore 里面的文件。

如果有些文件 (如 node_modules/) 需要多个 Jobs 共用的话，我们只能让每个 Job 都先执行一遍  npm install。

这样很不方便，因此我们需要对这些文件进行缓存。缓存了的文件除了可以跨 Jobs 使用外，还可以跨 Pipeline 使用。

具体用法请查看 [官方文档](http://docs.gitlab.com/ce/ci/yaml/README.html#cache)。

#### Job.script
定义 Job 要运行的命令，必填项。

#### Job.stage
定义 Job 的 stage，默认为 test。

#### Job.artifacts
定义 Job 中生成的附件。

当该 Job 运行成功后，生成的文件可以作为附件 (如生成的二进制文件) 保留下来，打包发送到 GitLab，之后我们可以在 GitLab 的项目页面下下载该附件。
> 注意，不要把 artifacts 和 cache 混淆了。

### 实用例子

#### 前端的 Gitlab CI 例子
以下是采集系统前端的配置
```
# 定义项目构建流程
stages:
  - install_deps
  - test
  - build
  - deploy_test
  - deploy_production
  - failure_cleanup
# 定义环境变量
variables:
  DEPLOY_PATH: "/usr/share/nginx/html/skynet-app-gather"
  DEPLOY_COMMOND: "deploy"
  BUILD_COMMOND: "build"
# 定义需要缓存的文件
cache:
  key: ${CI_BUILD_REF_NAME}
  paths:
    - node_modules/
    - dist/
# 安装依赖
install_deps:
  stage: install_deps
  only:
    - develop
    - master
  before_script:
    # 使用淘宝 NPM 镜像
    # - npm install -g cnpm --registry=https://registry.npm.taobao.org
  script:
    - cnpm install
# 运行测试用例
test:
  stage: test
  only:
    - develop
    - master
  script:
    - npm run test
# 编译
build:
  stage: build
  only:
    - develop
    - master
  before_script:
    # 若需要通过 git commit 控制 build 过程，请取消下面的注释
    # - if echo $(git log -1 --pretty=%B) | grep -o -E -i -s -q "${BUILD_COMMOND}"; then echo "building..."; else echo "Skipping ci build"; exit 0; fi
  script:
    - npm run clean
    - npm run build
# 部署测试服务器( commit信息包含‘deploy’会触发 )
deploy_test:
  stage: deploy_test
  only:
    - develop
  tags:
    - gather:hmly8
  before_script:
    - echo "git commit:" $(git log -1 --pretty=%B)
    - if echo $(git log -1 --pretty=%B) | grep -o -E -i -s -q "${DEPLOY_COMMOND}"; then echo "deploying..."; else echo "Skipping ci build"; exit 0; fi
  script:
    - sudo rm -rf ${DEPLOY_PATH}
    - sudo ln -sf `pwd` ${DEPLOY_PATH}
    #- sudo mv dist/ ${DEPLOY_PATH}
# 部署生产服务器
deploy_production:
  stage: deploy_production
  only:
    - master
  script:
    #- bash scripts/deploy/deploy.sh
    - echo 'to be continune...'
# 失败后清理
failure_cleanup:
  stage: failure_cleanup
  script:
  - npm cache clean
  - npm run clean
  when: on_failure
```

上面的配置把一次 Pipeline 分成五个阶段：
* 安装依赖(install_deps)
* 运行测试(test)
* 编译(build)
* 部署测试服务器(deploy_test)
* 部署生产服务器(deploy_production)

设置 Job.only 后，只有当 develop 分支和 master 分支有提交的时候才会触发相关的 Jobs。
> 注意，这里用 GitLab Runner 所在的服务器作为测试服务器(hmly8)。
> 

#### 后端的 Gitlab CI 例子
To be continue……

## 常见问题

### Permission denied 问题
gitlab runner 在执行脚本时，使用的是 gatlab-runner 用户，所以很容易会遇到权限不够的问题，针对这种情况，可以通过把 gatlab-runner 加入到权限更高的用户组内来避免，比如：
```
sudo usermod -a -G root gitlab-runner
```
或者授权使用 sudo 命令：
```
$ sudo visudo
# 在文件底部添加
gitlab-runner ALL=(ALL) NOPASSWD: ALL
```

### NPM INSTALL 过程慢
因为某墙问题，国内访问比较慢 npmjs.org 镜像，可以使用淘宝镜像来替代。
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```
然后 Script 可以使用 cnpm install 替代 npm install。

### gitlab-runner 删除失败
一般注销 gitlab-runner 的流程是：
```
# 获取 runner name：
gitlab-runner list
Listing configured runners                          ConfigFile=/etc/gitlab-runner/config.toml
test-runner                                         Executor=shell Token=eae25e1b92d7c01bb5087255a8d50e URL=http://git.sw.com/
gather-runner                                       Executor=shell Token=7239bab37e970cde07638d770708a9 URL=http://git.sw.com/ci/

# 注销runner
gitlab-runner unregister --name gather-runner

# 重启服务
gitlab-runner restart
```
若此时遇到 “Deleting runner... forbidden”时，可以修改 gitlab-runner 的 config 文件，删除相应的runner。
```
vim /etc/gitlab-runner/config.toml
```
