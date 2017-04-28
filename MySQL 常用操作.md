# MySQL 常用操作

## 备份
数据导出
```
mysqldump --lock-all-tables -u root -p --all-databases > dump.sql
```
数据导入
```
mysql -u root -p < dump.sql
```