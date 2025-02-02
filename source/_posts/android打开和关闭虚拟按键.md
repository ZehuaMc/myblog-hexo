---
title: android打开和关闭虚拟按键
date: 2022-08-26 00:44:29
updated: 2022-08-26 00:44:29
tags:
---
在system文件夹下的build.prop文件中修改qemu.hw.mainkeys值为1隐藏虚拟按键，为0时显示。底部虚拟按键显示与隐藏只需修改这个属性即可