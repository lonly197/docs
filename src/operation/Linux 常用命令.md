<!-- TOC -->

- [文件操作](#文件操作)
    - [查看各文件夹大小：](#查看各文件夹大小)
    - [打印目录结构：](#打印目录结构)
    - [生成目录结构（HTML）：](#生成目录结构html)
    - [远程复制文件夹](#远程复制文件夹)
- [进程操作](#进程操作)
    - [查看所有进程](#查看所有进程)
    - [查看非root进程](#查看非root进程)
    - [查看root进程](#查看root进程)
    - [显示进程的树状图](#显示进程的树状图)
    - [杀死进程名称中包含demo的所有进程](#杀死进程名称中包含demo的所有进程)
- [网络操作](#网络操作)
    - [查看Ip地址](#查看ip地址)

<!-- /TOC -->


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

## 进程操作

### 查看所有进程

```
ps aux | less
```

### 查看非root进程

```
ps -U root -u root -N
```

### 查看root进程

```
ps -U root
```

### 显示进程的树状图

```
pstree
``` 

### 杀死进程名称中包含demo的所有进程

```
ps aux | grep demo | awk '{print $2}' | xargs kill -9
```

## 网络操作

### 查看Ip地址

```
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
```

____
[Support By Lonly](mailto:lonly197@gmail.com)