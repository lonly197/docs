# CentOS 7 安装rar unrar实现解压缩RAR文件

## 下载
```SHELL
curl -Lk http://www.rarlab.com/rar/rarlinux-x64-5.4.0.tar.gz| tar -xz -C /tmp/
```

## 安装
```SHELL
cd /tmp/rar
make && make install
cd && rm -rf /tmp/rar/
```

## 检查
```SHELL
which {un,}rar
rar -v | head -3
```

____
[Support By Lonly](mailto:lonly197@gmail.com)