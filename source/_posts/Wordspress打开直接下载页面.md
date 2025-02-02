---
title: Wordspress打开直接下载页面
date: 2022-07-12 23:45:52
updated: 2022-07-12 23:45:52
tags:
---
# 问题
打开首页下载文件，文件内容
![2022-07-12T15:36:30.png][1]

```
<?php
/**
 * Front to the WordPress application. This file doesn't do anything, but loads
 * wp-blog-header.php which does and tells WordPress to load the theme.
 *
 * @package WordPress
 */
 
/**
 * Tells WordPress to load the WordPress theme and output it.
 *
 * @var bool
 */
define( 'WP_USE_THEMES', true );
 
/** Loads the WordPress Environment and Template */
require __DIR__ . '/wp-blog-header.php';
```

# 解决方法
----
清除浏览器缓存

  [1]: https://image.200502.xyz/i/2025/01/29/ozyaz1-0.webp