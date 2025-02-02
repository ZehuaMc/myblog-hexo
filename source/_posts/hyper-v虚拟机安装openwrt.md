---
title: hyper-v虚拟机安装openwrt
date: 2022-10-02 22:24:34
updated: 2022-10-02 22:24:34
tags:
---
设置网卡
----
在hyper-v管理器中选择虚拟交换机管理器，创建虚拟交换机，连接类型选择外部网络并选择你的物理网卡，勾选允许管理其他共享此网络适配器。![2022-10-02T14:05:25.png][1]
获取openwrt镜像
----
可以前往恩山论坛https://www.right.com.cn/forum/
之后使用StarWind V2V Converter转换镜像文件至hyper-v的文件
创建虚拟机
----
注意几点就好，关闭动态内存，内存分配 512MB，虚拟机代数选择第二代。
开机前设置
----
关闭安全启动![2022-10-02T14:09:49.png][2]
网络适配器的高级功能中启用MAC地址欺骗![2022-10-02T14:10:34.png][3]
开机后设置
----
输入`vi /etc/config/network`
按下c键即可输入，修改完成后按esc，接着输入:wq保存并退出。
将lan的ipaddr修改成你希望的地址![2022-10-02T14:13:30.png][4]
之后输入reboot重启
将openwrt设为网关
----
将默认网关改为你设置的openwrt的ip
![2022-10-02T14:22:10.png][5]

目前问题
----

网络中的其他设备更改网关后无法联网，只有宿主机可以
  [1]: https://image.200502.xyz/i/2025/01/29/ow8qa0-0.webp
  [2]: https://image.200502.xyz/i/2025/01/29/ow9gzb-0.webp
  [3]: https://image.200502.xyz/i/2025/01/29/owa5qj-0.webp
  [4]: https://image.200502.xyz/i/2025/01/29/owagir-0.webp
  [5]: https://image.200502.xyz/i/2025/01/29/owb3z1-0.webp