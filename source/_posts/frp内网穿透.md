---
title: frp内网穿透
updated: 2022-01-20	15:47:15
date: 2022-01-20	15:47:15
tags: []
categories: []
---
>作者水平有限，文章仅供参考，不对的地方希望各位及时指正，共同进步，不胜感激
            
            
# frp 内网穿透

## 简介

frp 是一款开源的内网穿透软件，github 主页为：https://github.com/fatedier/frp
其架构如下图所示：
![20220117182759](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117182759.png)

## Server 端

### 下载包

在 Release 页面下载服务器 CPU 架构对应的版本 https://github.com/fatedier/frp/releases
如果不知道，可以通过 lscpu 命令查看，一般为 arm_64 位或 X86_64 位。
![20220117185544](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117185544.png)
确定后通过 weget 命令下载。如 X86_64 对应下载为

```shell
weget https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_freebsd_amd64.tar.gz
```

github国内速度较慢，也可通过迅雷等工具下载到本地后通过 SecureCRT 等工具上传.

### 试运行

```shell
tar -zxvf frp_0.38.0_linux_amd64.tar.gz
```

解压成功后
打开目录下的 frps.ini 文件，修改如下

```shell
[common]
bind_port = 7000
token = mima
```

尝试启动服务

```shell
./frps -c frps.ini
```

成功一般有 success 提示信息，如果遇到 Segmentation fault 错误，检查下载的包版本是否有错。
### 后台运行服务

创建服务文件：
```shell
touch /etc/systemd/system/frp.service
```

修改 frp.service 内容如下：

```shell
[Unit]
Description=FRP service
After=network.target syslog.target
Wants=network.target

[Service]
ExecStart=/root/apps/frp/frps -c /root/apps/frp/frps.ini
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

重置守护进程服务

```shell
systemctl daemon-reload
```

开启服务

```js
systemctl start frp
```

检查服务是否开启成功，查看 7000 端口是否开启服务即可。

```shell
netstat -anp | grep 7000
```

注意，此处需要在服务器提供网站对应的配置处将 7000 端口的防火墙限制打开，centos 等系统下，注意 firewalld 是否开放防火墙端口。
如上操作完成后，服务即后台启动成功。
要想服务开机自启动，输入：
```shell
systemctl enable frp
```
即可。

## Client 端
### frpc配置
<!--more-->
本文Client 端此处采用 Docker 方式。
将下载的 frpc.ini 放在 Docker 宿主机本地
![20220117194957](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117194957.png)
frpc.ini 内容修改如下：

```shell
[common]
server_addr = 42.113.1.102
server_port = 7000
token = mima

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000

[DSM]
type = tcp
local_ip = 127.0.0.1
local_port = 5000
remote_port = 5000
```

如上配置后，意味着我们之后可以通过 42.113.1.102:5000 来进入群晖，通过 42.113.1.102:22 进入群晖后台。
### 添加 docker 镜像
![20220117195517](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117195517.png)
地址如下：
https://hub.docker.com/r/chenhw2/frp
下载完成后，双击镜像，做如下三处修改：

![20220117195707](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117195707.png)

![20220117195946](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117195946.png)

![20220117200053](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117200053.png)

应用修改后保存退出。

### 启动容器
![20220117200151](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/20220117200151.png)
点击开关容器启动成功即可，若启动失败，可在Details查看启动日志。

在外网环境在浏览器输入 42.113.1.102:5000
来到群晖登录页即穿透成功。
![frp内网穿透20220118112743](https://raw.githubusercontent.com/skylinety/blog-pics/master/imgs/frp%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8F20220118112743.png)            
            