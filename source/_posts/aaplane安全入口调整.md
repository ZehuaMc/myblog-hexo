---
title: aaplane安全入口调整
date: 2022-11-08 20:05:05
updated: 2022-11-08 20:05:05
tags:
---
问题：aaplane关闭安全入口后，依旧显示从正确入口进入
解决方法：在/www/server/panel/data下新建admin_path.pl
文件内输入`/安全入口`