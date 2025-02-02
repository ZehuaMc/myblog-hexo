---
title: Ubuntu使用clash-verge-rev启用tun模式
date: 2024-02-02 19:00:52
updated: 2024-02-02 19:00:52
tags:
---
# 问题
直接开启tun模式会因为权限不够无法连接外网，在ui界面授权同样提示权限不够
![2024-02-02T10:58:43.png][1]
# 解决方法
手动给clash-meta内核权限
`sudo chown root /bin/clash-meta`
`sudo chmod +sx /bin/clash-meta`
  [1]: https://image.200502.xyz/i/2025/01/29/ozvcme-0.webp