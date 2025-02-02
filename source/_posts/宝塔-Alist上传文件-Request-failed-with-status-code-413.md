---
title: 宝塔 Alist上传文件 Request failed with status code 413
date: 2022-12-17 21:23:25
updated: 2022-12-17 21:23:25
tags:
---
Alist上传大文件报错 Request failed with status code 413
![2022-12-17T13:20:57.png][1]
在宝塔的app store中找到nginx，修改配置文件
搜索client_max_body_size后面数字改大即可

  [1]: https://image.200502.xyz/i/2025/01/29/oukn42-0.webp