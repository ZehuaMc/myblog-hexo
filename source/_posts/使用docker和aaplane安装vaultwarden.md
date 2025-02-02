---
title: 使用docker和aaplane安装vaultwarden
date: 2022-11-08 22:30:07
updated: 2022-11-08 22:30:07
tags:
---
拉取docker镜像
----------

    docker pull vaultwarden/server:latest

启动容器
----
```
docker run -d --name vaultwarden \
  --restart unless-stopped \
  -e SIGNUPS_ALLOWED=true \
  -e WEBSOCKET_ENABLED=true \
  -v /vw-data/:/data/ \
  -p 81:80 \
  -p 3012:3012 \
  vaultwarden/server:latest
```
SIGNUPS_ALLOWED是允许注册，WEBSOCKET_ENABLED是自动同步，vm-data是存储数据的路径,81是你访问的端口。

设置反代
----
在网站设置中找到反向代理，并如图设置
![2022-11-08T14:27:56.png][1]
在反向代理的配置文件中添加
```
    location ^~ /notifications/hub {
        proxy_pass http://IP:3012;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location ^~ /notifications/hub/negotiate {
        proxy_pass http://IP:81;
    }
```
最后
----
享受你的bitwarden

  [1]: https://image.200502.xyz/i/2025/01/29/oztd7o-0.webp