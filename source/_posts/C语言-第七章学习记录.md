---
title: C语言|第七章学习记录
date: 2023-09-02 20:20:38
updated: 2023-09-02 20:20:38
tags:
---
- **if语句**：用于根据条件执行不同的分支。其一般形式为：

```c
if (expression)
    statement
```

如果`expression`为真（非0），则执行`statement`；否则，跳过`statement`。

- **if else语句**：用于在两个分支中选择一个执行。其一般形式为：

```c
if (expression)
    statement1
else
    statement2
```

如果`expression`为真（非0），则执行`statement1`；如果`expression`为假（0），则执行`statement2`。

- **else if语句**：用于实现多重选择。其一般形式为：

```c
if (expression1)
    statement1
else if (expression2)
    statement2
else
    statement3
```

如果`expression1`为真，执行`statement1`；如果`expression2`为真，执行`statement2`；否则，执行`statement3`。

- **else与if的配对**：如果没有花括号，else与离它最近的if匹配，除非最近的if被花括号括起来。

- **getchar()函数**：用于从输入队列中读取一个字符，并返回其ASCII码值。例如：

```c
ch = getchar();
```

将读取下一个字符输入，并把该字符的ASCII码值赋给变量ch。

- **putchar()函数**：用于打印一个字符到屏幕上。例如：

```c
putchar(ch);
```

将把变量ch的值作为字符打印出来。

这些函数只处理字符且不需要转换说明。

- **ctype.h头文件**：提供了一些字符映射函数，用于判断和转换字符的类型。例如：

```c
tolower(ch); // 返回ch对应的小写字母，不改变ch的值
ch = tolower(ch); // 把ch转换成小写字母，并赋值给ch
```
![2023-09-02T12:20:04.png][1]
- **逻辑运算符**：用于连接和操作布尔表达式，有以下三种：

  - `&&`：逻辑与，当两个操作数都为真时，结果为真；否则为假。
  - `||`：逻辑或，当两个操作数中有一个为真时，结果为真；否则为假。
  - `!`：逻辑非，当操作数为假时，结果为真；当操作数为真时，结果为假。

例如：

```c
exp1 && exp2 // 如果exp1和exp2都为真，则结果为真；否则为假
exp1 || exp2 // 如果exp1或exp2为真，则结果为真；否则为假
!exp1 // 如果exp1为假，则结果为真；如果exp1为真，则结果为假
```

- **iso646.h头文件**：提供了一些逻辑运算符的别名，可以用来替代上述三种运算符。例如：

```c
and // 等价于 &&
or // 等价于 ||
not // 等价于 !
```

- **逻辑运算符的优先级**：不同的逻辑运算符有不同的优先级，高优先级的运算符先被计算。一般来说：

  - `!`运算符的优先级最高，比乘法运算符还高，与递增运算符相同，只比圆括号低。
  - `&&`运算符的优先级比`||`运算符高，但是两者的优先级都比关系运算符低，比赋值运算符高。

- **逻辑运算符的求值顺序**：C语言保证逻辑表达式的求值顺序是从左往右。`&&`和`||`运算符都是序列点，所以在从一个操作数执行到下一个操作数之前，所有的副作用都会生效。而且，C语言保证一旦发现某个操作数让整个表达式无效，便立即停止求值。例如：

```c
if (range >= 90 && range <= 100) // 如果range小于90，就不会再判断range是否大于100
```
&&运算符可用于测试范围。例如：
```
if (range >= 90 && range <= 100)
```

- **条件表达式**：用于根据条件返回不同的值，相当于一种简化的if else语句。该表达式使用`?:`条件运算符。其一般形式为：

```c
expression1 ? expression2 : expression3
```

如果`expression1`为真（非0），那么整个条件表达式的值与`expression2`的值相同；如果`expression1`为假（0），那么整个条件表达式的值与`expression3`的值相同。

- **跳转语句**：用于改变程序的执行流程，有以下几种：

  - `continue`语句：用于跳过当前循环的剩余部分，并开始下一次循环。可以用于while, do while, for三种循环中。如果在嵌套循环中使用，只会影响包含该语句的内层循环。此外，continue只能用于循环中。尽管如此，如果switch语句在一个循环中，continue便可作为switch语句的一部分。这种情况下，就像在其他循环中一样，continue让程序跳出循环的剩余部分，包括switch语句的其他部分。
continue还可用作占位符。例如，下面的循环读取并丢弃输入的数据，直至读到行末尾，例如：
```
while (getchar() != '\n')
;
```
当程序已经读取一行中的某些内容，要跳至下一行开始处时，这种用法
很方便。问题是，一般很难注意到一个单独的分号。如果使用continue，可
读性会更高：
```
while (getchar() != '\n')
continue;
```
    对于for循环，执行continue后的下一个行为是对更新表达式求值，然后是对循环测试表达式求值。

  - `break`语句：用于终止当前循环或switch语句，并继续执行下一条语句。例如：

    ```c
    while (1)
    {
      ch = getchar();
      if (ch == 'q')
        break; // 如果输入q，退出循环
      putchar(ch);
    }
    ```
- **switch语句**：程序根据expression的值跳转至相应的case标签处。然后，执行剩下的所有语句，除非执行到break语句进行重定向。expression和case标签都必须是整数值（包括char类型），标签必须是常量或完全由常量组成的表达式。如果没有case标签与expression的值匹配，控制则转至标有default的语句（如果有的话）；否则，将转至执行紧跟在switch语句后面的语句。形式：
```
switch ( expression )
{
case label1 : statement1//使用break跳出switch
case label2 : statement2
default : statement3
}//可以有多个标签语句，default语句可选。
```


  [1]: https://image.200502.xyz/i/2025/01/29/p0cjee-0.webp