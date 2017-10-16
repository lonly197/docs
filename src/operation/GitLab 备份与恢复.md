# GitLab 备份与恢复

> 如果是生产环境，备份是必须的。需要备份的文件：配置文件和数据文件。
> 

<!-- TOC -->

- [GitLab 备份与恢复](#gitlab)
    - [备份配置文件](#)
    - [备份数据文件](#)
    - [恢复](#)

<!-- /TOC -->

## 备份配置文件
配置文件含密码等敏感信息，不要和数据备份文件放在一起。
```
sh -c 'umask 0077; tar -cf $(date "+etc-gitlab-%s.tar") -C /etc/gitlab'
```

## 备份数据文件
默认数据备份目录是/var/opt/gitlab/backups，手动创建备份文件：
```
# Omnibus 方式安装使用以下命令备份
sudo gitlab-rake gitlab:backup:create
```
日常备份，添加 crontab，运行crontab -e
```
# 每天2点执行备份
0 2 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create CRON=1
```
如要修改备份周期和目录，在/etc/gitlab/gitlab.rb中修改以下两个选项
```
# 设置备份周期为7天 - 604800秒
gitlab_rails['backup_keep_time'] = 604800
# 备份目录
gitlab_rails['backup_path'] = '/mnt/backups'
```

## 恢复
恢复之前，确保备份文件所安装 GitLab 和当前要恢复的 GitLab 版本一致。首先，恢复配置文件：
```
sudo mv /etc/gitlab /etc/gitlab.$(date +%s)
# 将下面配置备份文件的时间戳改为你所备份的文件的时间戳
sudo tar -xf etc-gitlab-1399948539.tar -C /
```

恢复数据文件
```
# 将数据备份文件拷贝至备份目录
sudo cp 1393513186_gitlab_backup.tar /var/opt/gitlab/backups/

# 停止连接数据库的进程
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop sidekiq

# 恢复1393513186这个备份文件，将覆盖GitLab数据库！
sudo gitlab-rake gitlab:backup:restore BACKUP=1393513186

# 启动 GitLab
sudo gitlab-ctl start

# 检查 GitLab
sudo gitlab-rake gitlab:check SANITIZE=true
```

[Support By Lonly](mailto:lonly197@gmail.com)