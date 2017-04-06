# Airflow安装部署与使用手册

## 1 Airflow 介绍
### 1.1 简介

[Airbnb](https://www.airbnb.co.uk/) 最近在Apache许可证下开源了它自己的数据工作流管理框架 [Airflow](http://nerds.airbnb.com/airflow/) 。Airflow被Airbnb内部用来创建、监控和调整数据管道。任何工作流都可以在这个使用Python来编写的平台上运行。

Airflow是一种允许工作流开发人员轻松创建、维护和周期性地调度运行工作流（即有向无环图或成为DAGs）的工具。在Airbnb中，这些工作流包括了如数据存储、增长分析、Email发送、A/B测试等等这些跨越多部门的用例。这个平台拥有和 Hive、Presto、MySQL、HDFS、Postgres和S3交互的能力，并且提供了钩子使得系统拥有很好地扩展性。除了一个命令行界面，该工具还提供了一个   [基于Web的用户界面](http://nerds.airbnb.com/wp-content/uploads/2015/06/Screen-Shot-2015-06-02-at-9.47.12-AM.png) 让您可以可视化管道的依赖关系、监控进度、触发任务等。


### 1.2 特性

- 动态性: Airflow pipeline是以python code形式做配置, 灵活性没得说了.
- 扩展性: 可以自定义operator(运算子), 有几个executor(执行器)可供选择.
- 优雅:pipeline的定义很简单明了, 基于jinja模板引擎很容易做到脚本命令参数化
- 扩展性:模块化的结构, 加上使用了message queue来编排多个worker(启用CeleryExcutor), airflow可以做到无限扩展.


### 1.3 比较优势

linkedin的Azkaban很不错, UI尤其很赞, 使用java properties文件维护上下游关系, 任务资源文件需要打包成zip, 部署不是很方便.

Apache Oozie, 使用XML配置, Oozie任务的资源文件都必须存放在HDFS上。 配置不方便同时也只能用于Hadoop。

Spotify的 Luigi UI 用户体验不好。

airflow 总体都不错, 有实用的UI, 丰富的cli工具, Task上下游使用python编码，能保证灵活性和适应性。

## 2 Airflow 架构

### 2.1 本地模式

* Airflow Web服务器
* Airflow 调度器
* 元数据库（MySQL）

### 2.2 分布式架构

* 一个元数据库（MySQL或Postgres）
* 一组Airflow工作节点
* 一个调节器（Redis或RabbitMQ）
* 一个Airflow Web服务器


## 3 Airflow 基本感念

### 3.1 Operator

基本可以理解为一个抽象化的task, Operator加上必要的运行时上下文就是一个task. 有三类Operator:

* Sensor(传感监控器), 监控一个事件的发生。
* Trigger(或者叫做Remote Excution), 执行某个远端动作, (我在代码中没有找到这个类别)。
* Data transfer(数据转换器), 完成数据转换。

### 3.2 Hooks

Hook是airflow与外部平台/数据库交互的方式, 一个Hook类就像是一个JDBC driver一样. airflow已经实现了jdbc/ftp/http/webhdfs很多hook. 要访问RDBMS数据库 有两类Hook可供选择, 基于原生Python DBAPI的Hook和基于JDBC的Hook, 以Oracle为例,

* OracleHook, 是通过cx\_Oracle 访问Oracle数据, 即原生Python binding, 有些原生的Hook支持Bulk load。
* JdbcHook, 是通过jaydebeapi+Oracle JDBC访问Oracle数据

### 3.3 Tasks

task代表DAG中的一个节点, 它其实是一个BaseOperator子类。

### 3.4 Task instances

即task的运行态实例, 它包含了task的status(成功/失败/重试中/已启动)

### 3.5.Job

Airflow中Job很少提及, 但在数据库中有个job表, 需要说明的是Job和task并不是一回事, Job可以简单理解为Airflow的批次, 更准确的说法是同一批被调用task或dag的统一代号。有三类Job, 分别SchedulerJob/BackfillJob/LocalTaskJob, 对于SchedulerJob和BackfillJob, job指的是指定dag这次被调用的运行时代号, LocalTaskJob是指定task的运行时代号。

### 3.6 Connections

我们的Task需要通过Hook访问其他资源, Hook仅仅是一种访问方式, 就像是JDBC driver一样, 要连接DB, 我们还需要DB的IP/Port/User/Pwd等信息. 这些信息不太适合hard code在每个task中, 可以把它们定义成Connection, airflow将这些connection信息存放在后台的connection表中. 我们可以在WebUI的Admin-&gt;Connections管理这些连接.

### 3.7 Variables

Variable 没有task\_id/dag\_id属性, 往往用来定义一些系统级的常量或变量,  我们可以在WebUI或代码中新建/更新/删除Variable. 也可以在WebUI上维护变量.

Variable 的另一个重要的用途是, 我们为Prod/Dev环境做不同的设置

### 3.8 XComs

XCom和Variable类似, 用于Task之间共享一些信息. XCom 包含task\_id/dag\_id属性, 适合于Task之间传递数据, XCom使用方法比Variables复杂些. 比如有一个dag, 两个task组成(T1-&gt;T2), 可以在T1中使用xcom\_push()来推送一个kv, 在T2中使用xcom\_pull()来获取这个kv.

### 3.9 Trigger Rules

可以为dag中的每个task都指定它的触发条件, 这里的触发条件有两个维度, 以T1;T2>T3 这样的dag为例:

一个维度是: 要根据dag上次运行T3的状态确定本次T3是否被调用, 由DAG的default\_args.depends\_on\_past参数控制, 为True时, 只有上次T3运行成功, 这次T3才会被触发

另一个维度是: 要根据前置T1和T2的状态确定本次T3是否被调用, 由T3.trigger\_rule参数控制, 有下面6种情形, 缺省是all\_success.

* all\_success: (default) all parents have succeeded

* all\_failed: all parents are in a failed or upstream\_failed state

* all\_done: all parents are done with their execution

* one\_failed: fires as soon as at least one parent has failed, it does not wait for all parents to be done

* one\_success: fires as soon as at least one parent succeeds, it does not wait for all parents to be done

* dummy: dependencies are just for show, trigger at will

### 3.10 DAG分支

airflow有两个基于PythonOperator的Operator来支持dag分支功能.

ShortCircuitOperator, 用来实现流程的判断. Task需要基于ShortCircuitOperator, 如果本Task返回为False的话, 其下游Task将被skip; 如果为True的话, 其下游Task将会被正常执行.  尤其适合用在其下游都是单线节点的场景.

BranchPythonOperator, 用来实现Case分支. Task需要基于BranchPythonOperator, airflow会根据本task的返回值(返回值是某个下游task的id),来确定哪个下游Task将被执行, 其他下游Task将被skip.

### 3.11 Executor

有三个 Executor 可供选择, 分别是: SequentialExecutor 和 LocalExecutor 和 CeleryExecutor, SequentialExecutor仅仅适合做Demo(搭配Sqlite backend), LocalExecutor 和 CeleryExecutor 都可用于生产环境, CeleryExecutor 将使用 Celery 作为Task执行的引擎, 扩展性很好, 当然配置也更复杂, 需要先setup Celery的backend(包括RabbitMQ, Redis)等. 其实真正要求扩展性的场景并不多, 所以LocalExecutor 是一个很不错的选择了.


## 4 Airflow 系统表

### 4.1 connection 表:

我们的Task往往需要通过jdbc/ftp/http/webhdfs方式访问其他资源, 一般地访问资源时候都需要一些签证, airflow允许我们将这些connection以及鉴证存放在connection表中.可以现在WebUI的Admin-&gt;Connections管理这些连接, 在代码中使用这些连接.

需要说明的是, connection表有2个id栏位, 一个是id, 一个是conn\_id, id栏位是该表的PK, conn\_id栏位是connection的名义id, 也就是说我们可以定义多个同名的conn\_id, 当使用使用时airflow将会从同名的conn\_id的列表中随机选一个, 有点基本的load balance的意思.

### 4.2 user 表 :

包含user的username和email信息. 我们可以在WebUI的Admin->Users管理.

### 4.3 variable 表 :

包含定义variable

### 4.4 xcom 表:

包含xcom的数据

### 4.5 dag 表:

包含dag的定义信息, dag\_id是PK(字符型)

### 4.6 dag\_run 表:

包含dag的运行历史记录, 该表也有两个id栏位, 一个是id, 一个是run\_id, id栏位是该表的PK, run\_id栏位是这次运行的一个名字(字符型), 同一个dag, 它的run\_id 不能重复.

物理PK: 即id栏位

逻辑PK: dag\_id + execution\_date 组合

execution\_date 栏位, 表示触发dag的准确时间

> 注意: 没有 task 表: airflow的task定义在python源码中, 不在DB中存放注册信息.

### 4.7 task\_instance 表:

物理PK: 该表没有物理PK

逻辑PK: dag\_id + task\_id + execution\_date 组合.

execution\_date 栏位, 表示触发dag的准确时间,是datetime类型字段

start\_date/end\_date 栏位,表示执行task的起始/终止时间, 也是datetime类型字段

job 表: 包含job(这里可以理解为批次)的运行状态信息


## 5 Airflow 命令介绍
### 5.1 初始化airflow meta db
```
airflow initdb [-h]
```
### 5.2 升级airflow meta db
```
airflow upgradedb [-h]
```
### 5.3 开启web server
```
airflow webserver  --debug=False
```
开启airflow webserver, 但不进入flask的debug模式

### 5.4 显示task清单
```
airflow list\_tasks --tree=True -sd=/home/docs/airflow/dags
```
以Tree形式, 显示/home/docs/airflow/dags下的task 清单

### 5.5 检查Task状态
```
airflow task\_state  -sd=/home/docs/airflow/dags dag\_id task\_id execution\_date
```
这里的 execution\_date 是触发dag的准确时间, 是DB的datetime类型, 而不是Date类型


### 5.6 开启一个dag调度器

airflow scchedule dagId

启动dag调度器, 注意启动调度器, 并不意味着dag会被马上触发, dag触发需要符合它自己的schedule规则.

参数NUM\_RUNS, 如果指定的话, dag将在运行NUM\_RUNS次后退出. 没有指定时, scheduler将一直运行.

参数DAG\_ID可以设定, 也可以缺省, 含义分别是:

如果设定了DAG\_ID, 则为该DAG\_ID专门启动一个scheduler;

如果缺省DAG\_ID, airflow会为每个dag(subdag除外)都启动一个scheduler.


### 5.7 立即触发一个dag, 可以为dag指定一个run id, 即dag的运行实例id.

airflow trigger\_dag [-h] [-r RUN\_ID] dag\_id

立即触发运行一个dag, 如果该dag的scheduler没有运行的话, 将在scheduler启动后立即执行dag


### 5.8 批量回溯触发一个dag

airflow backfill [-s START\_DATE] [-e END\_DATE]  [-sd SUBDIR]  --mark\_success=False --dry\_run=False dag\_id

有时候我们需要\*\*立即\*\*批量补跑一批dag, 比如为demo准备点执行历史, 比如补跑错过的运行机会. DB中dag execute\_date记录不是当下时间, 而是按照 START\_DATE 和 scheduler\_interval 推算出的时间.

如果缺省了END\_DATE参数, END\_DATE等同于START\_DATE.


### 5.9.手工调用一个Task

airflow run [-sd SUBDIR] [-s TASK\_START\_DATE] --mark\_success=False  dag\_id task\_id execution\_date

该命令参数很多, 如果仅仅是测试运行, 建议使用test命令代替.


### 5.10.测试一个Task
```
airflow test -sd=/home/docs/airflow/dags --dry\_run=False dag\_id task\_id execution\_date

airflow test -sd=/home/docs/airflow/dags --dry\_run=False dag\_id task\_id 2015-12-31

以 test 或 dry\_run 模式 运行作业.
```


### 5.11.清空dag下的Task运行实例
```
airflow clear [-s START\_DATE] [-e END\_DATE]  [-sd SUBDIR]  dag\_id
```


### 5.12.显示airflow的版本号
```
airflow version
```


## 6 Airflow 安装配置
### 6.1 环境

| 软件 | 版本 | 说明 |
| --- | --- | --- |
| CentOS | 6.7 |   |
| Python | 2.7.11 |   |
| pip | 8.1.2 | 可选，python2.7.11已自带python -m pip |

### 6.2 安装步骤

```
1)安装python
tar -xzf Python-2.7.11.tgz
cd  Python-2.7.11
./configure
make
make install


2)设置环境变量使用新版本python（linux存在旧版本）
cd ~
ls -a
vi .bash\_profile
PATH=$PATH:$HOME/bin
export PATH=/root/Python-2.7.11:$PATH


3)安装setuptools
tar -xzvf setuptools-23.0.0.tar.gz
cd  setuptools-23.0.0
python setup.py build
pyhont setup.py install


4)安装pip
tar -xzvf pip-8.1.2.tar.gz
cd pip-8.1.2
python setup.py install


5)修改环境变量
vi .bash\_profile
export AIRFLOW\_HOME=/data/airflow


6)安装airflows
pip install airflow


7)安装新特征
pip install airflow[hive]
pip install airflow[mysql]


8)修改本地模式

#airflow数据目录
airflow\_home = /data/airflow

#dag查找目录
dags\_folder = /data/airflow/dags

#设置为本地模式
executor = LocalExecutor

#元数据存储地址 (mysql)
sql\_alchemy\_conn = mysql://root:root@192.1.1.111:3306/airflow

#不加载例子
load\_examples = false


9)初始化db
airflow initdb


10)启动web server
airflow webserver -p 8080


11)启动 scheduler
airflow scheduler &amp;


12)停止scheduler
ps -ef | grep &#39;/bin/airflow scheduler&#39; | awk &#39;{print $2}&#39; | xargs -i kill -9 {}
```


## 7 Airflow 开发

### 7.1 Dag脚本开发

dag脚本可参考example\_dags目录中的sample, 然后将脚本存放到airflow.cfg指定的dags\_folder下.

airflow 已经包含实现很多常用的 operator, 包括 BashOperator/EmailOperator/JdbcOperator/PythonOperator/ShortCircuitOperator/BranchPythonOperator/TriggerDagRunOperator等, 基本上够用了, 如果要实现自己的Operator, 继承BaseOperator, 一般只需要实现execute()方法即可. execute()约定没有返回值, 如果execute()中抛出了异常, airflow则会认为该task失败.

pre\_execute()/post\_execute()用处不大, 不用特别关注, 另外post\_execute()是在on\_failure\_callback/on\_success\_callback回调函数之前执行的, 所以, 也不适合回写作业状态.

作业流程串接的几个小贴士:

-  使用 DummyOperator 来汇聚分支

-  使用 ShortCircuitOperator/BranchPythonOperator 做分支

-  使用 SubDagOperator 嵌入一个子dag

-  使用 TriggerDagRunOperator  直接trigger 另一个dag

-  T\_B.set\_upstream(T\_A), T\_A-&gt;T\_B, 通过task对象设置它的上游

-  T\_1.set\_downstream(T\_2), T\_1-&gt;T\_2 , 通过task对象设置它的下游

-  airflow.utils.chain(T\_1, T\_2, T\_3), 通过task对象设置依赖关系, 这个方法就能一次设置长的执行流程, T\_1-&gt;T\_2-&gt;T\_3

-  dag.set\_dependency(&#39;T\_1\_id&#39;, &#39;T\_2\_id&#39;), 通过id设置依赖关系



### 7.2 Dag运行测试

```
1)先测试pytnon代码正确性
python ~/airflow/dags/tutorial.py


2)通过命令行验证DAG/task设置
# print the list of active DAGs
airflow list\_dags

# prints the list of tasks the &quot;tutorial&quot; dag\_id
airflow list\_tasks tutorial

# prints the hierarchy of tasks in the tutorial DAG
airflow list\_tasks tutorial --tree


3)通过test命令行试跑一下, 测试一下code逻辑
airflow test tutorial my\_task\_id 2015-06-01


4)通过 backfill --mark\_success=True
airflow backfill tutorial -s 2015-06-01 -e 2015-06-07
```


## 8. 与现有系统集成相关问题

### 8.1 如何在现有系统上定义一个dag

* 前期预先在线下定义DAG文件，直接由前端页面触发调用。
* DAG记录预先录入
* DAG文件中的可配置项通过参数变量覆盖。


### 8.2. 如何上传DAG文件到AirHome/dags目录
目录共享


### 8.3. 怎样触发DAG 运行
开放调用接口，接口执行dag schedule 命令


### 8.4. 如何在现有系统上的任务列表里反映任务状态
不需同步状态，直接使用Airflow WEB UI