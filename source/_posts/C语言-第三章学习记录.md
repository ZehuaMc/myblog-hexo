---
title: C语言|第三章学习记录
date: 2023-08-11 13:46:17
updated: 2023-08-11 13:46:17
tags:
---
## 整数

- 整数类型有多种，如 **short** , **int** , **long** , **long long** , **unsigned long** , **unsigned int** 等。
- 把一个较小的常量作为 **long** 类型对待，可以在值的末尾加上 **l** 或 **L** 后缀，如 `10L` 。
- 使用 **ll** 或 **LL** 后缀来表示 **long long** 类型的值，如 `3LL` 。另外，使用 **u** 或 **U** 后缀表示 **unsigned long long** ，如 `5ull` , `10LLU` , `6LLU` 或 `9Ull` 。
- 打印 **unsigned int** 类型的值，使用 `%u` 转换说明；打印 **long** 类型的值，使用 `%ld` 转换说明。
- 以十进制显示数字，使用 `%d` ；以八进制显示数字，使用 `%o` ；以十六进制显示数字，使用 `%x` 。另外，要显示各进制数的前缀 `0` , `0x` 和 `0X` ，必须分别使用 `%#o` , `%#x` , `%#X` 。
- 在 `x` 和 `o` 前面可以使用 **l** 前缀， `%lx` 表示以十六进制格式打印 **long** 类型整数， `%lo` 表示以八进制格式打印 **long** 类型整数。
- 对于 **short** 类型，可以使用 **h** 前缀。 `%hd` 表示以十进制显示 **short** 类型的整数， `%ho` 表示以八进制显示 **short** 类型的整数。 **h** 和 **l** 前缀都可以和 **u** 一起使用，用于表示无符号类型。例如， `%lu` 表示打印 **unsigned long** 类型的值。
- 对于支持 **long long** 类型的系统， `%lld` 和 `%llu` 分别表示有符号和无符号类型。

## 浮点数

- 浮点数类型有三种，分别是 **float** , **double** , **long double** 。
- 转换说明有三种，分别是 `%f` , `%lf` , `%Lf` 。
- printf()函数使用 `%f` 转换说明打印十进制记数法的 **float** 和 **double** 类型浮点数，用 `%e` 打印指数记数法的浮点数。如果系统支持十六进制格式的浮点数，可用 `a` 和 `A` 分别代替 `e` 和 `E` 。
- 打印 **long double** 类型要使用 `%Lf` , `%Le` ,或 `%La` 转换说明。
- 为了打印新类型的变量，在printf()中使用 `%f` 来处理浮点值。 `%.2f` 中的 `.2` 用于精确控制输出，指定输出的浮点数只显示小数点后面两位。

## 练习题
![2023-08-11T05:41:01.png][1]
1.十进制整数，%d
2.十六进制整数，%x/%X
3.字符，%c
4.浮点数科学计数法
```
double num = 2.34E07;
prinft("%e",num);
```
5.转义字符（空格），直接使用```printf("Hello\040World");```或
```
char escape='\040';
printf("%c",escape);
```
6.浮点数，%f
7.长整型，%ld
8.单精度浮点数，%f
9.十六进制浮点数，%a/%A
![2023-08-11T06:12:37.png][2]
1.八进制整数，%o
2.长双精度浮点数,%le
3.字符,%c
4.长整型,%ld(本题中int为16位，最大32768)
5.直接使用
6.单精度浮点数,%f
7.十六进制整数,%x
8.复整数,%d
假设ch是char类型的变量。分别使用转义序列、十进制值、八进制字
符常量和十六进制字符常量把回车字符赋给ch（假设使用ASCII编码值）。
ch ='\r'
ch = 13
ch = '\015'
ch = '\x0D'
  [1]: https://image.200502.xyz/i/2025/01/29/ozu1qq-0.webp
  [2]: https://image.200502.xyz/i/2025/01/29/ozur6f-0.webp