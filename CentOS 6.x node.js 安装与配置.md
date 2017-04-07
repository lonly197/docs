# CentOS 6.x node.js 安装与配置

> 本文以v7.8.0为例
> 

## 安装步骤

**下载源码**
```
cd /opt/package
wget --no-check-certificate https://nodejs.org/dist/v7.8.0/node-v7.8.0.tar.gz
```

**编译安装**
```
tar zxvf node-v7.8.0.tar.gz
cd node-v7.8.0
./configure
make && make install
```

**配置环境**

配置NODE_HOME，进入profile编辑环境变量
```

```

## 问题

**C++ compiler too old**

如果在安装过程中提示“C++ compiler too old, need g++ 4.8 or clang++ 3.4 (CXX=g++)”的话，那么此时就需要升级gcc了。
```
# 下载gcc
cd /opt/package
wget http://gcc.skazkaforyou.com/releases/gcc-4.8.5/gcc-4.8.5.tar.gz

# 编译安装gcc
tar -zxvf gcc-4.8.5.tar.gz
cd gcc-4.8.5
mkdir build
cd build
yum install gmp-devel mpfr-devel libmpc-devel
../configure --prefix=/usr
make && make install
```