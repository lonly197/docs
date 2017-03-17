# Java常用类库

<!-- TOC -->

- [Java常用类库](#java)
    - [Guice](#guice)
    - [OkHttp](#okhttp)
    - [Retrofit](#retrofit)
    - [JDeferred](#jdeferred)

<!-- /TOC -->

## Guice
Guice (发音同 ‘juice’) ，是一个 Google 开发的轻量级依赖性注入框架，适合 Java 6 以上的版本。
```
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
```
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
```
public interface GitHubService {
    @GET("users/{user}/repos")
    Call<List<Repo>listRepos(@Path("user") String user);
}
```
Retrofit 类实现 GitHubService 接口：
```
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.github.com/")
    .build();
 
GitHubService service = retrofit.create(GitHubService.class);
```
来自 GitHubService 的每个 Call 都能产生为远程 Web 服务产生一个异步或同步 HTTP 请求：
```
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