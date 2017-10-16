# Technical Documentation

<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="Author" content="Made by 'tree'">
 <meta name="GENERATOR" content="$Version: $ tree v1.7.0 (c) 1996 - 2014 by Steve Baker, Thomas Moore, Francesc Rocher, Florian Sesser, Kyosuke Tokoro $">
 <title>Directory Tree</title>
 <style type="text/css">
  <!--
  BODY { font-family : ariel, monospace, sans-serif; }
  P { font-weight: normal; font-family : ariel, monospace, sans-serif; color: black; background-color: transparent;}
  B { font-weight: normal; color: black; background-color: transparent;}
  A:visited { font-weight : normal; text-decoration : none; background-color : transparent; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  A:link    { font-weight : normal; text-decoration : none; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  A:hover   { color : #000000; font-weight : normal; text-decoration : underline; background-color : yellow; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  A:active  { color : #000000; font-weight: normal; background-color : transparent; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  .VERSION { font-size: small; font-family : arial, sans-serif; }
  .NORM  { color: black;  background-color: transparent;}
  .FIFO  { color: purple; background-color: transparent;}
  .CHAR  { color: yellow; background-color: transparent;}
  .DIR   { color: blue;   background-color: transparent;}
  .BLOCK { color: yellow; background-color: transparent;}
  .LINK  { color: aqua;   background-color: transparent;}
  .SOCK  { color: fuchsia;background-color: transparent;}
  .EXEC  { color: green;  background-color: transparent;}
  -->
 </style>
</head>
<body>
        <h1>Directory Tree</h1><p>
        ├── <a href="./LICENSE">LICENSE</a><br>
        ├── <a href="./README.md">README.md</a><br>
        └── <a href="./src/">src</a><br>
        &nbsp;&nbsp;&nbsp; ├── <a href="./src/development/">development</a><br>
        &nbsp;&nbsp;&nbsp; │   ├── <a href="./src/development/Java%20%E5%B8%B8%E7%94%A8%E7%B1%BB%E5%BA%93.md">Java 常用类库.md</a><br>
        &nbsp;&nbsp;&nbsp; │   ├── <a href="./src/development/Lombok%20%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97.md">Lombok 开发指南.md</a><br>
        &nbsp;&nbsp;&nbsp; │   └── <a href="./src/development/Vue.js%20%E5%B8%B8%E7%94%A8%E7%BB%84%E4%BB%B6.md">Vue.js 常用组件.md</a><br>
        &nbsp;&nbsp;&nbsp; └── <a href="./src/operation/">operation</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Airflow%20%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2%E4%B8%8E%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.md">Airflow 安装部署与使用手册.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20nginx%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.xnginx安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20node.js%20%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.x node.js 安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20or%207.x%20MySQL%205.7%20%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.x or 7.x MySQL 5.7 安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20python%202.6%20%E5%8D%87%E7%BA%A7%E5%88%B0%202.7%20%E5%8F%8A%20pip%20%E5%AE%89%E8%A3%85.md">CentOS 6.x python 2.6 升级到 2.7 及 pip 安装.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20%E4%B8%8A%E5%AE%89%E8%A3%85Dockers1.7.md">CentOS 6.x 上安装Dockers1.7.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20%E7%B3%BB%E7%BB%9F%E5%86%85%E6%A0%B8%E5%8D%87%E7%BA%A7.md">CentOS6.x 系统内核升级.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%207%20%E8%AE%BE%E7%BD%AE%20ulimit%20%E8%B5%84%E6%BA%90%E9%99%90%E5%88%B6.md">CentOS 7 设置 ulimit 资源限制.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%207%20%E5%AE%89%E8%A3%85rar%20unrar%E5%AE%9E%E7%8E%B0%E8%A7%A3%E5%8E%8B%E7%BC%A9RAR%E6%96%87%E4%BB%B6.md">CentOS 7 安装rar unrar实现解压缩RAR文件.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/ElasticSearch%205%20%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2%20Head%20%E6%8F%92%E4%BB%B6.md">ElasticSearch 5 安装部署 Head 插件.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/ElasticSearch%205%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md">ElasticSearch 5 安装及配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20CI%20%E6%8C%81%E7%BB%AD%E9%9B%86%E6%88%90.md">GitLab CI 持续集成.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20Runner%E5%AE%89%E8%A3%85%E4%B8%8E%E9%83%A8%E7%BD%B2.md">GitLab Runner安装与部署.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20%E5%A4%87%E4%BB%BD%E4%B8%8E%E6%81%A2%E5%A4%8D.md">GitLab 备份与恢复.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GtiLab%20%E5%AE%89%E8%A3%85%E5%8F%8A%E6%B1%89%E5%8C%96.md">GtiLab 安装及汉化.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Linux%20%E7%8E%AF%E5%A2%83%20JDK%201.8%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md">Linux 环境 JDK 1.8 安装及配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Linux%20%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4.md">Linux 常用命令.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/MySQL%20%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C.md">MySQL 常用操作.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85%20Scala.md">Ubuntu 安装 Scala.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Hadoop%202.7%20on%20Yarn.md">Ubuntu 安装Hadoop 2.7 onYarn.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Hbase%202.1.1.md">Ubuntu 安装Hbase 2.1.1.md</a><br>
LonlydeMacBook-Pro:docs lonlyhuang$ tree -N -H .<!DOCTYPE html>
<html><head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <meta name="Author" content="Made by 'tree'">
 <meta name="GENERATOR" content="$Version: $ tree v1.7.0 (c) 1996 - 2014 by Steve Baker, Thomas Moore, Francesc Rocher, Florian Sesser, Kyosuke Tokoro $">
 <title>Directory Tree</title>
 <style type="text/css">
  <!--
  BODY { font-family : ariel, monospace, sans-serif; }
  P { font-weight: normal; font-family : ariel, monospace, sans-serif; color: black; background-color: transparent;}
  B { font-weight: normal; color: black; background-color: transparent;}
  A:visited { font-weight : normal; text-decoration : none; background-color : transparent; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: in
line; }
  A:link    { font-weight : normal; text-decoration : none; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  A:hover   { color : #000000; font-weight : normal; text-decoration : underline; background-color : yellow; margin : 0px 0px 0px 0px; padding : 0px 0px 0px
 0px; display: inline; }
  A:active  { color : #000000; font-weight: normal; background-color : transparent; margin : 0px 0px 0px 0px; padding : 0px 0px 0px 0px; display: inline; }
  .VERSION { font-size: small; font-family : arial, sans-serif; }
  .NORM  { color: black;  background-color: transparent;}
  .FIFO  { color: purple; background-color: transparent;}
  .CHAR  { color: yellow; background-color: transparent;}
  .DIR   { color: blue;   background-color: transparent;}
  .BLOCK { color: yellow; background-color: transparent;}
  .LINK  { color: aqua;   background-color: transparent;}
  .SOCK  { color: fuchsia;background-color: transparent;}
  .EXEC  { color: green;  background-color: transparent;}
  -->
 </style>
</head>
<body>
        <h1>Directory Tree</h1><p>
        <a href=".">.</a><br>
        ├── <a href="./LICENSE">LICENSE</a><br>
        ├── <a href="./README.md">README.md</a><br>
        └── <a href="./src/">src</a><br>
        &nbsp;&nbsp;&nbsp; ├── <a href="./src/development/">development</a><br>
        &nbsp;&nbsp;&nbsp; │   ├── <a href="./src/development/Java%20%E5%B8%B8%E7%94%A8%E7%B1%BB%E5%BA%93.md">Java 常用类库.md</a><br>
        &nbsp;&nbsp;&nbsp; │   ├── <a href="./src/development/Lombok%20%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97.md">Lombok 开发指南.md</a><br>
        &nbsp;&nbsp;&nbsp; │   └── <a href="./src/development/Vue.js%20%E5%B8%B8%E7%94%A8%E7%BB%84%E4%BB%B6.md">Vue.js 常用组件.md</a><br>
        &nbsp;&nbsp;&nbsp; └── <a href="./src/operation/">operation</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Airflow%20%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2%E4%B8%8E%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.md">Airflow 安装部署与使用手册.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20nginx%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.xnginx安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20node.js%20%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.x node.js 安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20or%207.x%20MySQL%205.7%20%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AE.md">CentOS 6.x or 7.x MySQL 5.7 安装与配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20python%202.6%20%E5%8D%87%E7%BA%A7%E5%88%B0%202.7%20%E5%8F%8A%20pip%20%E5%AE%89%E8%A3%85.md">CentOS 6.x python 2.6 升级到 2.7 及 pip 安装.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20%E4%B8%8A%E5%AE%89%E8%A3%85Dockers1.7.md">CentOS 6.x 上安装Dockers1.7.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%206.x%20%E7%B3%BB%E7%BB%9F%E5%86%85%E6%A0%B8%E5%8D%87%E7%BA%A7.md">CentOS6.x 系统内核升级.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%207%20%E8%AE%BE%E7%BD%AE%20ulimit%20%E8%B5%84%E6%BA%90%E9%99%90%E5%88%B6.md">CentOS 7 设置 ulimit 资源限制.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/CentOS%207%20%E5%AE%89%E8%A3%85rar%20unrar%E5%AE%9E%E7%8E%B0%E8%A7%A3%E5%8E%8B%E7%BC%A9RAR%E6%96%87%E4%BB%B6.md">CentOS 7 安装rar unrar实现解压缩RAR文件.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/ElasticSearch%205%20%E5%AE%89%E8%A3%85%E9%83%A8%E7%BD%B2%20Head%20%E6%8F%92%E4%BB%B6.md">ElasticSearch 5 安装部署 Head 插件.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/ElasticSearch%205%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md">ElasticSearch 5 安装及配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20CI%20%E6%8C%81%E7%BB%AD%E9%9B%86%E6%88%90.md">GitLab CI 持续集成.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20Runner%E5%AE%89%E8%A3%85%E4%B8%8E%E9%83%A8%E7%BD%B2.md">GitLab Runner安装与部署.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GitLab%20%E5%A4%87%E4%BB%BD%E4%B8%8E%E6%81%A2%E5%A4%8D.md">GitLab 备份与恢复.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/GtiLab%20%E5%AE%89%E8%A3%85%E5%8F%8A%E6%B1%89%E5%8C%96.md">GtiLab 安装及汉化.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Linux%20%E7%8E%AF%E5%A2%83%20JDK%201.8%20%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE.md">Linux 环境 JDK 1.8 安装及配置.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Linux%20%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4.md">Linux 常用命令.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/MySQL%20%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C.md">MySQL 常用操作.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85%20Scala.md">Ubuntu 安装 Scala.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Hadoop%202.7%20on%20Yarn.md">Ubuntu 安装Hadoop 2.7 onYarn.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Hbase%202.1.1.md">Ubuntu 安装Hbase 2.1.1.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Spark%202.1.0%20on%20Yarn.md">Ubuntu 安装Spark 2.1.0 on Yarn.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./src/operation/Ubuntu%20%E5%AE%89%E8%A3%85Zookeeper%203.4.9.md">Ubuntu 安装Zookeeper 3.4.9.md</a><br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; └── <a href="./src/operation/%E4%BD%BF%E7%94%A8%20supervisor%20%E7%AE%A1%E7%90%86%E8%BF%9B%E7%A8%8B.md">使用 supervisor 管理进程.md</a><br>
        <br><br>
        </p>
        <p>

3 directories, 29 files
        <br><br>
        </p>
        <hr>
        <p class="VERSION">
            Suport © 2017 By Lonly
        </p>
</body>
</html>