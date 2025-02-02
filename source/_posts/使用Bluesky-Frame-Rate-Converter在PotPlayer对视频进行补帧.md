---
title: 使用Bluesky Frame Rate Converter在PotPlayer对视频进行补帧
date: 2022-10-01 23:21:57
updated: 2022-10-01 23:21:57
tags:
---
要求
--
GNC或者Vega 架构的AMD显卡
安装
--
下载Bluesky Frame Rate Converter [官网传送门][1]
BlueskyFRC_4.1.0_Setup.exe [点我下载Bluesky Frame Rate Converter][2](链接失效)
下载PotPlayer [官网传送门][3]

配置
--

 1. 配置Bluesky Frame Rate Converter
如图进行选择，其中output选择输出的视频帧率
![2022-10-01T15:16:16.png][4]
 2. 配置PotPlayer
在选项-滤镜-全局滤镜优先权中，添加系统滤镜选择Bluesky Frame Rate Converter，并且优先顺序选择强制使用![2022-10-01T15:19:59.png][5]
享受
--
随便打开一个视频，按Tab键即可看到播放帧率
![2022-10-01T15:21:27.png][6]


  [1]: https://bluesky-soft.com/en/BlueskyFRC.html
  [2]: https://pan.200502.xyz/d/Onedrive/%E5%8D%9A%E5%AE%A2%E6%96%87%E4%BB%B6/BlueskyFRC_4.1.0_Setup.exe
  [3]: https://potplayer.tv/
  [4]: https://image.200502.xyz/i/2025/01/29/ozad9c-0.webp
  [5]: https://image.200502.xyz/i/2025/01/29/ozaxo3-0.webp
  [6]: https://image.200502.xyz/i/2025/01/29/ozc0tq-0.webp