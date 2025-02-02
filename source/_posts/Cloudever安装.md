---
title: Cloudever安装
date: 2022-07-13 13:11:38
updated: 2022-07-13 13:11:38
tags:
---
Cloudever官网：[传送门][1]
![请输入图片描述][2]
安装
--
```
#从github下载最新文件到服务器上https://github.com/cloudreve/Cloudreve/releases/download/3.5.3/cloudreve_3.5.3_linux_amd64.tar.gz
#解压获取到的主程序
tar -zxvf cloudreve_VERSION_OS_ARCH.tar.gz
# 赋予执行权限
chmod +x ./cloudreve
# 启动 Cloudreve
./cloudreve
```
## 进程守护 ##

 - systemd
```
# 编辑配置文件
vim /usr/lib/systemd/system/cloudreve.service
```
将下文 `PATH_TO_CLOUDREVE` 更换为程序所在目录：
```
[Unit]
Description=Cloudreve
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=/PATH_TO_CLOUDREVE
ExecStart=/PATH_TO_CLOUDREVE/cloudreve
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target
```
```
# 更新配置
systemctl daemon-reload

# 启动服务
systemctl start cloudreve

# 设置开机启动
systemctl enable cloudreve
```
管理命令:
```
# 启动服务
systemctl start cloudreve

# 停止服务
systemctl stop cloudreve

# 重启服务
systemctl restart cloudreve

# 查看状态
systemctl status cloudreve
```
使用宝塔进行反向代理
----------
新建网页
![2022-07-13T05:22:35.png][3]
设置反向代理
![2022-07-13T05:25:46.png][4]
启用ssl

  [1]: https://cloudreve.org/
  [2]: https://image.200502.xyz/i/2025/01/29/ozm8tt-0.webp
  [3]: https://image.200502.xyz/i/2025/01/29/ozmxgu-0.webp
  [4]: https://image.200502.xyz/i/2025/01/29/oznoby-0.webp