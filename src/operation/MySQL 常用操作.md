# MySQL 常用操作

## 备份
数据导出
```SHELL
mysqldump --lock-all-tables -u root -p --all-databases > dump.sql
```
数据导入
```SHELL
mysql -u root -p < dump.sql
```

查看MYSQL数据库中所有用户
```SQL
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;
```

查看所有密码策略
```SQL
SHOW VARIABLES LIKE 'validate_password%';
```

密码策略设置为最低
```SQL
set global validate_password_policy=0;
```

密码长度设置为4位
```SQL
set global validate_password_length=4;
```

____
[Support By Lonly](mailto:lonly197@gmail.com)