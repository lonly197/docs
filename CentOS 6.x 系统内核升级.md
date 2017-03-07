# CentOS 6.x 系统内核升级

> 使用Yum快速更新升级CentOS内核
> 
<!-- TOC -->

- [CentOS 6.x 系统内核升级](#centos-6-x)
    - [导入 Public Key](#public-key)
    - [安装 ELRepo](#elrepo)
    - [升级 Kernel](#kernel)
    - [更改 Grub](#grub)
    - [查看 Kernel](#kernel)

<!-- /TOC -->

## 导入 Public Key
```
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
```

## 安装 ELRepo
**CentOS 5**
```
rpm -Uvh http://www.elrepo.org/elrepo-release-5-5.el5.elrepo.noarch.rpm
```
**CentOS 6**
```
rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
```
**CentOS 7**
```
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```

## 升级 Kernel
> 这里需要注意的是，在 ELRepo 中有两个内核选项，一个是 kernel-lt(长期支持版本)，一个是 kernel-ml(主线最新版本)，我采用长期支持版本(kernel-lt)，更稳定一些，毕竟是给服务器用的
**kernel-lt**
```
yum --enablerepo=elrepo-kernel install kernel-lt -y
```
**kernel-ml**
```
yum --enablerepo=elrepo-kernel install kernel-ml -y
```

## 更改 Grub
```
vi /etc/grub.conf
```
根据安装好以后的内核位置，修改 default 的值，一般是修改为0，因为 default 从 0 开始，一般新安装的内核在第一个位置，所以设置<font size='3' color='red'>default=0</font>

## 查看 Kernel
所有操作都执行完毕以后，重启主机，重启后执行 uname -r，查看内核版本号，判断是否升级成功

[Support By Lonly](mailto:lonly197@gmail.com)