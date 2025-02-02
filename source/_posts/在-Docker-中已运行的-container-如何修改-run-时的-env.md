---
title: 在 Docker 中已运行的 container 如何修改 run 时的 env
date: 2022-07-25 21:24:32
updated: 2022-07-25 21:24:32
tags:
---
首先不推荐这样做，如需修改配置，应删掉重新部署。

其次，可以进行如下操作（未测试，不知道仅重启 container 是否可以达到同样效果）：

1. ```service docker stop```

2. 修改/var/lib/docker/containers/[container-id]/config.json里对应的环境变量

3. 然后```service docker start```。

4. 查看效果： ```docker exec -it [container-id] env```
转自[https://www.cnblogs.com/xiaouisme/p/9837221.html][1]


  [1]: https://www.cnblogs.com/xiaouisme/p/9837221.html