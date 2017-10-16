# Linux 常用命令

## 文件操作

### 查看各文件夹大小：
```
du -h -a -c --max-depth=1
```

### 打印目录结构：
```
find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

### 生成目录结构（HTML）：
```
tree -N -H .
```


### 远程复制文件夹
```
scp -r local_file remote_username@remote_ip:remote_folder
```

## 环境设置

### 修改环境变量
```
vim ~/.profile


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
PATH="$PATH:/usr/local/hadoop/bin"


source ./.profile
echo $PATH
```
