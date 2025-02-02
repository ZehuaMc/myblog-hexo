---
title: ECC在高速多端口共享缓存管理模块中的实现
date: 2024-03-02 20:56:00
updated: 2024-03-02 20:56:00
tags:
---
# 汉明码纠错
对于64bit的数据，需要额外的8bit来存储纠错码
## Side-band ECC
对每个sram额外添加一个8bit位宽的sram来存储纠错码。
![2024-03-02T12:39:43.png][1]
## Inline ECC
将纠错码跟数据存储到同一sram，跟在数据包的末尾。最大需要额外的16拍数据来存储纠错码。
# LDPC码纠错
[LDPC码（一种前向纠错码）：基础 & 译码算法][2]
[LDPC译码算法的简单实现：从C++到Verilog][3]


  [1]: https://image.200502.xyz/i/2025/01/29/nv655g.webp
  [2]: https://zhuanlan.zhihu.com/p/514670102
  [3]: https://zhuanlan.zhihu.com/p/522496709