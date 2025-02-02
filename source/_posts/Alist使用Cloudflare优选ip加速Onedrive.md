---
title: Alist使用Cloudflare优选ip加速Onedrive
date: 2023-01-24 01:34:57
updated: 2023-01-24 01:34:57
tags:
---
本文介绍了如何利用CloudflareSpeedTest和Cf Worker来提高Alist和Onedrive的访问速度和下载速度。

## 教程

- 由该[大佬](https://github.com/Xhofe/alist/issues/923)给出的方案，首先下载[CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)，然后按下列步骤：
- 筛选优选ip，并将Alist域名a.b.net通过cf解析，并再增加一个加速域名cf.b.net设置A记录至优选ip（关闭云朵）；
- 参照alist官方教程设置Cf Worker（命名如：alistworker），代码见https://github.com/alist-org/alist-proxy/blob/main/alist-proxy.js；注意：HOST: 你的Alist地址，必须添加协议头，且后面不能添加/。如https://alist.nn.ci；TOKEN：参见Alist部分的Token
- 设置Worker路由：点击添加路由按钮，路由填cf.b.net/*服务下拉菜单选刚建好的alistworker然后保存；
- 在Alist管理面板编辑Onedrive账号，在down_proxy_url填入https://cf.b.net保存并刷新缓存。

## 问题

- 网页下载1101错误

![1101错误.png][1]

- 解决方法

设置worker路由的域名不能跟alist的域名下相同

如，我的alist域名是a.b.net,那么我设置Worker路由的域名就不能使用*.b.net。

[1]: https://image.200502.xyz/i/2025/01/29/oz6dbk-0.webp