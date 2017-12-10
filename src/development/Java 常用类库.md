# Java常用类库

<!-- TOC -->

- [Java常用类库](#java常用类库)
    - [Guice](#guice)
    - [OkHttp](#okhttp)
    - [Retrofit](#retrofit)
    - [JDeferred](#jdeferred)
    - [Spark Framework](#spark-framework)
    - [Sharding-JDBC](#sharding-jdbc)
    - [Eureka](#eureka)
    - [Jedis](#jedis)

<!-- /TOC -->


## Guice
Guice (发音同 ‘juice’) ，是一个 Google 开发的轻量级依赖性注入框架，适合 Java 6 以上的版本。
```JAVA
# Typical dependency injection
public class DatabaseTransactionLogProvider implements Provider<TransactionLog> {
  @Inject Connection connection;
 
  public TransactionLog get() {
    return new DatabaseTransactionLog(connection);
  }
}

# FactoryModuleBuilder generates factory using your interface
public interface PaymentFactory {
   Payment create(Date startDate, Money amount);
 }
```

[Github](https://github.com/google/guice)


## OkHttp
HTTP是现代应用程序实现网络连接的途径，也是我们进行数据和媒体交换的工具。高效使用HTTP能使你的东西加载更快，并节省带宽。

OkHttp是一个非常高效的HTTP客户端，默认情况下：
* 支持HTTP/2，允许对同一主机的请求共用一个套接字。
* 如果HTTP/2 不可用，连接池会减少请求延迟。
* 透明的GZIP可以减少下载流量。
* 响应的缓存避免了重复的网络请求。
```JAVA
OkHttpClient client = new OkHttpClient();
 
String run(String url) throws IOException {
  Request request = new Request.Builder()
      .url(url)
      .build();
 
  Response response = client.newCall(request).execute();
  return response.body().string();
}
```

[Github](https://github.com/square/okhttp)


## Retrofit
Retrofit 是 Square 下的类型安全的 HTTP 客户端，支持 Android 和 Java 等，它能将你的 HTTP API 转换为 Java 接口。
Retrofit 将 HTTP API 转换为 Java 接口：
```JAVA
public interface GitHubService {
    @GET("users/{user}/repos")
    Call<List<Repo>listRepos(@Path("user") String user);
}
```

Retrofit 类实现 GitHubService 接口：
```JAVA
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.github.com/")
    .build();
 
GitHubService service = retrofit.create(GitHubService.class);
```

来自 GitHubService 的每个 Call 都能产生为远程 Web 服务产生一个异步或同步 HTTP 请求：
```JAVA
Call<List<Repo>> repos = service.listRepos("octocat");
```

[Github](https://github.com/square/retrofit)


## JDeferred

* 与JQuery类似的Java Deferred/Promise类库
* Deferred 对象和 Promise
* Promise 回调：.then(…), .done(…), .fail(…), .progress(…), .always(…)
* 支持多个promises - .when(p1, p2, p3, …).then(…)
* Callable 和 Runnable - wrappers.when(new Runnable() {…})
* 使用 Executor 服务
* 支持Java 泛型： Deferred<Integer, Exception, Doubledeferred;, deferred.resolve(10);, deferred.reject(new Exception());,deferred.notify(0.80);,
* 支持Android
* Java 8 Lambda的友好支持

[Github](https://github.com/jdeferred/jdeferred)


## Spark Framework
Spark 框架是一个轻量级的 Java web 框架，用来进行快速的开发，它有一个不到1M的最小化的内核， 提供了所有基本的特性, 用来构建 RESTful 或者传统的 web 应用程序。
```JAVA
import static spark.Spark.*;
 
public class HelloWorld {
   public static void main(String[] args) {
      get("/hello", (req, res) -> "Hello World");
   }
}
```
> 这个框架适合初始开发。主要用作小小项目或者原型。

[Github](https://github.com/perwendel/spark)


## Sharding-JDBC
Sharding-JDBC定位为轻量级java框架，使用客户端直连数据库，以jar包形式提供服务，未使用中间层，无需额外部署，无其他依赖，DBA也无需改变原有的运维方式，可理解为增强版的JDBC驱动，旧代码迁移成本几乎为零。

* sharding-jdbc-transaction完全基于java开发，直接提供jar包，可直接使用maven导入坐标即可使用。
* 为了保证事务不丢失，sharding-jdbc-transaction需要提供数据库存储事务日志，配置方法可参见事务管理器配置项。
* 由于柔性事务采用异步尝试，需要部署独立的作业和Zookeeper。sharding-jdbc-transaction采用elastic-job实现的sharding-jdbc-transaction-async-job，通过简单配置即可启动高可用作业异步送达柔性事务，启动脚本为start.sh。
* 为了便于开发，sharding-jdbc-transaction提供了基于内存的事务日志存储器和内嵌异步作业。

```JAVA
// 1. 配置SoftTransactionConfiguration
SoftTransactionConfiguration transactionConfig = new SoftTransactionConfiguration(dataSource);
transactionConfig.setXXX();
    
// 2. 初始化SoftTransactionManager
SoftTransactionManager transactionManager = new SoftTransactionManager(transactionConfig);
transactionManager.init();
    
// 3. 获取BEDSoftTransaction
BEDSoftTransaction transaction = (BEDSoftTransaction) transactionManager.getTransaction(SoftTransactionType.BestEffortsDelivery);
    
// 4. 开启事务
transaction.begin(connection);
    
// 5. 执行JDBC
/* 
    codes here
*/
* 
// 6.关闭事务
transaction.end();
```

[Github](https://github.com/dangdangdotcom/sharding-jdbc)

## Eureka
Eureka是Netflix开发的服务发现组件，本身是一个基于REST的服务。

Eureka由两个组件组成：Eureka服务器和Eureka客户端。Eureka服务器用作服务注册服务器。Eureka客户端是一个java客户端，用来简化与服务器的交互、作为轮询负载均衡器，并提供服务的故障切换支持。Netflix在其生产环境中使用的是另外的客户端，它提供基于流量、资源利用率以及出错状态的加权负载均衡。

[github](https://github.com/Netflix/eureka)


## Jedis
Jedis是一个Java语言的Redis客户端。

```
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.9.0</version>
    <type>jar</type>
    <scope>compile</scope>
</dependency>
```

```
```


____
[Support By Lonly](mailto:lonly197@gmail.com)