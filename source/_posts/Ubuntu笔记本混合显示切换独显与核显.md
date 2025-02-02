---
title: Ubuntu笔记本混合显示切换独显与核显
date: 2024-02-25 13:28:00
updated: 2024-02-25 13:28:00
tags:
---
笔记本是AMD核显与NVIDIA独显
AMD不需要单独安装驱动，NVIDIA安装了闭源驱动
切换核显
```
prime-select intel
```
切换回混合显示
```
prime-select on-demand
```