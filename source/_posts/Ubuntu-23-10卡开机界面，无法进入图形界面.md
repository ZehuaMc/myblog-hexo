---
title: Ubuntu 23.10卡开机界面，无法进入图形界面
date: 2024-02-02 15:24:16
updated: 2024-02-02 15:24:16
tags:
---
# 重装nvdia驱动
## 卸载
`sudo apt remove nvdia-*`
`sudo apt autoremove`
## 安装
查询合适的显卡驱动`ubuntu-drivers devices`
安装驱动`sudo ubuntu-drivers autoinstall`
# 关闭文件系统检查
在`/etc/default/grub`文件的行`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`中添加`fsck.mode=skip`，例`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash fsck.mode=skip"`。
然后使用命令`sudo update-grub`。
# 重新安装ubuntu桌面
`sudo apt-get install ubuntu-desktop`
之后重启即可。