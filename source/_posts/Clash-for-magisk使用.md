---
title: Clash for magisk使用
date: 2022-10-02 22:02:19
updated: 2022-10-02 22:02:19
tags:
---
安装
----------
模块下载

[CMFM_202209281336.zip][1]

在magisk里安装

![2022-10-02T13:19:38.png][2]

安装dashboard 

[DashBoard-v5.4.r186.d655c85-release.apk][3]

![2022-10-02T13:20:47.png][4]

修改配置
----
配置文件位于`/data/clash/config.yaml`
 1. 添加订阅
示例
```
proxy-providers:
  机场名:
    type: http
    url: "订阅地址"
    path: ./proxy_providers/机场名.yaml
    interval: 3600
    filter: '^((?!游戏).)*$' #过滤名字中带游戏的节点
    health-check:
      enable: true
      url: http://www.gstatic.com/generate_204
      interval: 300
```
 2. 代理组设置
```
proxy-groups:
 name: Proxy
    type: select
    proxies:
      - 机场名
      - 机场名-auto
      - DIRECT
 name: 机场名
    type: select
    use:
      - 机场名
 name: 机场名-auto
    type: url-test
    use:
      - 机场名
```
 3. 更换代理
在dashboard中的网页面板更换

参考资料
---
https://docs.adlyq.ml/
https://docs.metacubex.one/
---

  [1]: https://t.me/blowH2O/550168
  [2]: https://image.200502.xyz/i/2025/01/29/owd6s4-0.webp
  [3]: https://t.me/blowH2O/542701
  [4]: https://image.200502.xyz/i/2025/01/29/owdtzp-0.webp
