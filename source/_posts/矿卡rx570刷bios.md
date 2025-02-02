---
title: 矿卡rx570刷bios
date: 2022-11-13 13:13:48
updated: 2025-01-29 13:13:48
tags:
---
开机后显卡被Windows停止（错误43）
---------------------

使用DDU卸载显卡驱动并关闭Windows更新。

刷入bios时提示id错误
-------------

使用atiflash（2.93版本），并对amdvbflash.exe创建快捷方式，修改目标
```
C:\Users\15195\Desktop\atiflash_293\amdvbflash.exe -p -f 0 "D:\Download\映泰578原版bios(2).rom"
```
![2022-11-13T05:05:23.png][1]
以管理员身份运行即可刷入。
有时提示缺少关键文件，下载aitfalsh最新版安装它的驱动即可
文件链接(文件丢失了)：https://pan.200502.xyz/%E6%9C%AC%E5%9C%B0/rx570%E7%9F%BF%E5%8D%A1
  [1]: https://image.200502.xyz/i/2025/01/29/owcdxx-0.webp