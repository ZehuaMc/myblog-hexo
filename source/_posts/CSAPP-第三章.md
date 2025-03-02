---
title: CSAPP|第三章
date: 2024-02-21 01:32:00
updated: 2024-02-21 01:32:00
tags:
---
# 3.1历史观点
# 3.2程序编码
假设一个C程序，有两个文件p1.c和p2.c。用命令行编译这些代码：
```
linux> gcc -Og -o p p1.c p2.c
```
命令gcc指的就是GCC C编译器。因为这是Linux上默认的编译器，我们也可以简单地用cc来启动它。编译选项-Og告诉编译器使用会生成符合C代码整体结构的机器代码优化等级。使用较高级别优化产生的代码会严重变形，以至于产生的机器代码和初始源代码之间的关系非常难以理解。
命令gcc即GCC C编译器，-Og告诉编译器使用生成符合原始c代码整体结构的机器代码的优化等级。最终产生可执行代码文件p（由-o p指定）
## 3.2.1 机器级代码
计算机系统的两种重要抽象：
- 指令集架构（ISA）：定义了处理器状态、指令的格式，以及每条指令对状态的影响。大多数ISA，包括x86-64，将程序的行为描述成好像每条指令都是按顺序执行的，一条指令结束后，下一条再开始。
- 虚拟地址：提供的内存模型看上去是一个非常大的字节数组。

x86-64的机器代码和原始的C代码差别非常大。一些通常对C语言程序员隐藏的处理器状态都是可见的：
- 程序计数器(通常称为“PC”，在x86-64中用rip表示)给出将要执行的下一条指令在内存中的地址。
- 整数寄存器文件包含16个命名的位置，分别存储64位的值。这些寄存器可以存储地址(对应于C语言的指针)或整数数据。有的寄存器被用来记录某些重要的程序状态，而其他的寄存器用来保存临时数据，例如过程的参数和局部变量，以及函数的返回值。
- 条件码寄存器保存着最近执行的算术或逻辑指令的状态信息。它们用来实现控制或数据流中的条件变化，比如说用来实现if和while语句。
- 一组向量寄存器可以存放一个或多个整数或浮点数值。

一条机器指令只执行一个非常基本的操作。例如，将存放在寄存器中的两个数字相加，在存储器和寄存器之间传送数据，或是条件分支转移到新的指令地址。编译器必须产生这些指令的序列，从而实现(像算术表达式求值、循环或过程调用和返回这样的)程序结构。
## 3.2.2 代码示例
在命令行上使用“-S”选项，就能看到C语言编译器产生的汇编代码`linux> gcc -Og -S mstore.c`，产生一个mastore.s汇编文件。
![2024-02-22T14:02:42.png][1]
使用“-c”命令行选项，GCC会编译并汇编该代码：`linux> gcc -Og -c mstore.c`得到一个目标代码文件mstore.o，它是二进制格式的。
要查看机器代码文件的内容，可以使用被称为反汇编器（disassembler）的程序。程序根据机器代码产生一种类似于汇编代码的格式。在Linux系统中，带‘-d’命令行标志的程序OBJDUMP（表示”object dump”）可以充当这个角色。`linux> objdump -d test.o`
![2024-02-22T14:03:07.png][2]
其中一些关于机器代码和它的反汇编表示的特性值得注意：
- x86-64的指令长度从1到15个字节不等。常用的指令以及操作数较少的指令所需的字节数少，而那些不太常用或操作数较多的指令所需字节数较多。
- 设计指令格式的方式是，从某个给定位置开始，可以将字节唯一地解码成机器指令。例如，只有指令pushq %rbx是以字节值53开头的。
- 反汇编器只是基于机器代码文件中的字节序列来确定汇编代码。它不需要访问该程序的源代码或汇编代码。
- 反汇编器使用的指令命名规则与GCC生成的汇编代码使用的有些细微的差别。在我们的示例中，它省略了很多指令结尾的‘q’。这些后缀是大小指示符，在大多数情况中可以省略。相反，反汇编器给call和ret指令添加了‘q’后级，同样，省略这些后缀也没有问题。

生成实际可执行的代码需要对一组目标代码文件运行链接器，而这一组目标代码文件中必须含有一个main函数。我们用如下方法生成可执行文件prog：`linux> gcc -Og -0 prog main.c mstore.c`不仅包含了两个过程的代码，还包含了用来启动和终止程序的代码，以及用来与操作系统交互的代码。
![2024-02-22T14:14:56.png][3]
反汇编后：
![2024-02-22T14:09:08.png][4]
主要区别：
- 左边地址不同，链接器将这段代码地址移动到了一段不同的地址范围中。
- 链接器填上了callq指令调用函数mult2需要使用的地址。
# 3.3 数据格式
由于是从16位体系结构扩展成32位的，Intel用术语“字（word）”表示16位数据类型。因此，称32位数为”双字（double word）”，称64位数为“四字（quad word）”。
![2024-02-23T09:36:31.png][5]
GCC生成的汇编代码指令都有一个字符的后缀，表明操作数的大小，例数据传送指令mov有：movb（传送字节）、movw（传送字）、mov1l（传送双字）和mova（传送四字）。

# 3.4 访问信息
一个x86-64的中央处理单元(CPU)包含一组16个存储64位值的通用目的寄存器。这些寄存器用来存储整数数据和指针。
![2024-02-23T10:59:05.png][6]
嵌套的方框标明的指令可以对16个寄存器的低位字节中存放的不同大小的数据进行操作。对于生成小于8字节结果的指令，寄存器中剩下的字节会怎么样，对此有两条规则：
- 生成1字节和2字节数字的指令会保持剩下的字节不变。
- 生成4字节数字的指令会把高位4个字节置为0。

## 3.4.1操作数指示符
大多数指令有一个或多个操作数（operand），指示出执行一个操作中要使用的源数据值，以及放置结果的目的位置。各种不同的操作数的可能性被分为三种类型：
- 立即数（immediate）：立即数的书写方式是'$'后面跟一个用标准C表示法表示的整数。
- 寄存器（register）：我们用符号r_a表示任意寄存器a，用引用R[r_a]来表示它的值，这是将寄存器集合看成一个数组R，用寄存器表示符作为索引。
- 内存引用：M_b[Addr]表示对存储在内存中从地址Addr开始的b个字节值的引用（为了简便，我们通常省去下标b）。
![2024-02-23T12:51:27.png][7]

## 3.4.2 数据传送指令
许多不同的指令被划分成指令类，每一类中的指令执行相同的操作，只不过操作数大小不同。

### 最简单形式的数据传送指令一MOV类
把数据从源位置复制到目的位置，不做任何变化。
- 源操作数指定的值是一个立即数，存储在寄存器中或内存中。目的操作数指定一个位置，要么是一个寄存器或者是一个内存地址。
- x86-64加了一条限制，传送指令的两个操作数不能都指向内存位置。将一个值从一个内存位置复制到另一个内存位置需要两条指令——第一条指令将源值加载到寄存器中，第二条将该寄存器值写入目的位置。
- movl指令只会更新目的操作数指定的那些寄存器字节或内存位置，但movl指令以寄存器作为目的时，它会把该寄存器的高位4字节设置为0（x86-64采用的惯例，即任何为寄存器生成32位值的指令都会把该寄存器的高位部分置成0。）
常规的mova指令只能以表示为32位补码数字的立即数作为源操作数，然后把这个值符号扩展得到64位的值，放到目的位置。movabsaq指令能够以任意64位立即数值作为源操作数，并且只能以寄存器作为目的。
![2024-02-23T14:16:06.png][8]
### MOVZ类
最后两个字符都是大小指示符：第一个字符指定源的大小，而第二个指明目的的大小。
MOVZ类中的指令把目的中剩余的字节填充为0。
![2024-02-23T14:23:09.png][9]
### MOVS类
最后两个字符都是大小指示符：第一个字符指定源的大小，而第二个指明目的的大小。
MOVS类中的指令通过符号扩展来填充，把源操作的最高位进行复制。
![2024-02-23T14:23:21.png][10]

## 3.4.3 数据传送示例
![2024-02-23T15:02:26.png][11]
过程参数xp和y分别存储在寄存器%rdi和%rsi中。然后，指令2从内存中读出x，把它存放到寄存器%rax中，直接实现了C程序中的操作x=*xp。稍后，用寄存器%rax从这个函数返回一个值，因而返回值就是x。指令3将y写入到寄存器%rdi中的xp指向的内存位置，直接实现了操作*xp=y。

C语言中所谓的“指针”其实就是地址。间接引用指针就是将该指针放在一个寄存器中，然后在内存引用中使用这个寄存器。
## 3.4.4压入和弹出栈数据
栈可以实现位一个数组，总是从数组的一段插入和删除元素。这一端被称为栈顶。
栈向下增长。
![2024-02-23T15:25:24.png][12]
![2024-02-23T15:25:48.png][13]
一个四字值压入栈中，首先要将栈指针减8，然后将值写到新的栈顶地址。因此，指令pushq rbp的行为等价于下面两条指令 ：![2024-02-23T15:27:49.png][14]
弹出一个四字的操作包括从栈顶位置读出数据，然后将栈指针加8。因此，指令popq %rax等价于下面两条指令:![2024-02-23T15:28:57.png][15]
# 3.5 算术逻辑操作
![2024-02-23T15:43:35.png][16]
## 3.5.1 加载有效地址（leaq指令）
加载有效地址（load effective address）指令leaq实际上是movq指令的变形，它将有效地址写入到目的操作数，我们用C语言的地址操作符&S说明这种计算。leaq指令能执行加法和有限形式的乘法：
![2024-02-24T06:22:48.png][17]

## 3.5.2 一元和二元操作
一元操作只有一个操作数，即是源又是目的。这个操作数可以是一个寄存器，也可以是一个内存位置。
二元操作的第一个操作数可以是立即数，寄存器或是内存地址。第二个操作数可以是寄存器或是内存位置。

## 3.5.3 移位操作
移位量可以是一个立即数，或是放在单字节寄存器%cl中。
x86-64中，移位操作对w位长的数据值进行操作，移位量由%cl寄存器的低m决定的，这里2^m=w。高位会被忽略。
移位操作的目的操作数可以是一个寄存器或是一个内存位置。
## 3.5.5 特殊的操作数
x86-64 指令集对128 位(16字节)数的操作提供有限的支持。
![2024-02-24T08:03:10.png][18]
乘法的两条指令要求一个参数必须在寄存器%rax中，而另一个作为指令的源操作数给出。乘积存放在寄存器%rdx（高64位）和%rax（低64位）中。
有符号除法指令idivl将寄存器%rdx（高64位）和%rax（低64位）中的128位数作为被除数，而除数作为指令的操作数给出。指令将商存储在寄存器%rax中，将余数存储在寄存器%rdx中。
对于大多数64位除法应用来说，除数也常常是一个64位的值。这个值应该存放在%rax中，%rdx的位应该设置为全0（无符号运算）或者rax的符号位（有符号运算）。这个操作可以用指令cqto来完成。cqto指令不需要操作数，它隐含读出%rax的符号位，并将它复制到%rdx的所有位。
# 3.6 控制
机器代码提供两种基本的低级机制来实现有条件的行为：测试数据值，然后根据测试的结果来改变控制流或者数据流。
使用jump指令可以改变一组机器代码指令的执行顺序，jump指令指定控制应该被传递到程序的某个其他部分，可能是依赖于某个测试的结果。
## 3.6.1 条件码
CPU还维护着一组单个位的条件码（condition code）寄存器，它们描述了最近的算术或逻辑操作的属性，常用的有：![2024-02-25T07:46:00.png][19]
- leaq指令不改变任何条件码，因为它是用来进行地址计算的。除此之外，图3-10中列出的所有指令都会设置条件码。
- 对于逻辑操作，例如XOR，进位标志和溢出标志会设置为0。
- 对于移位操作，进位标志将设置为最后一个被移出的位，而溢出标志设置为0。
- INC和DEC指令会设置溢出和零标志，但是不会改变进位标志。
还有两类指令（有8、16、32和64位形式），它们只设置条件码而不改变任何其他寄存器
![2024-02-25T07:47:51.png][20]
- CMP指令根据两个操作数的差来设置条件码。除了只设置条件码而不更新目的寄存器之外，CMP指令与SUB指令的行为是一样的。
- TEST指令的行为和AND指令一样，除了它们只设置条件码而不改变目的寄存器的值。典型的用法是，两个操作数是一样的（例如，testq %rax，%rax用来检查%rax是负数、零还是正数），或其中的一个操作数是一个掩码，用来指示哪些位应该被测试。
## 3.6.2 访问条件码
条件码通常不会直接读取，常用的使用方法有三种：
- 1）可以根据条件码的某种组合，将一个字节设置为0或者1
- 2）可以条件跳转到程序的某个其他部分
- 3）可以有条件地传送数据
对于方法1,将这一整类指令称为SET指令，一条SET指令的目的操作数是低位字节寄存器元素（图3-2）之一，或是一个字节的内存位置，指令会将这个字节设置成0或者1。
![2024-02-25T11:31:45.png][21]
一个计算C语言表达式a<b的典型指令序列如下所示,这里a和b都是long类型;
![2024-02-25T11:34:21.png][22]

## 3.6.3 跳转指令
跳转（jump）指令会导致执行切换到程序中一个全新的位置，跳转的目的地通常用一个标号（label）指明。例如：![2024-02-25T11:48:53.png][23]
jmp指令是无条件跳转。它可以是直接跳转，即跳转目标是作为指令的一部分编码的；也可以是间接跳转，即跳转目标是从寄存器或内存位置中读出的。
- 直接跳转是给出一个标号作为跳转目标的，例如上面所示代码中的标号.L1。
- 间接跳转的写法是在*后面跟一个操作数指示符，使用图3-3中描述的内存操作数格式中的一种。例如，`jmp *%rax`用寄存器%rax中的值作为跳转目标，`jmp *(%rax)`以%rax中的值作为读地址，从内存中读出跳转目标。
![2024-02-25T11:49:50.png][24]
## 3.6.4 跳转指令的编码
跳转指令有几种不同的编码：
- **PC相对的（PC-relative）：** 它们会将目标指令的地址与紧跟在跳转指令后面那条指令的地址之间的差作为编码。
- **“绝对”地址：** 用4个字节直接指定目标。
PC相对的例子：![2024-02-25T12:16:49.png][25]
第二个跳转指令的目标用单字节、补码表示编码为0xf8（十进制-8）。将这个数加上0xd（十进制13），即第6行指令的地址，我们得到0x5，即第3行指令的地址。
## 3.6.5 用条件控制来实现条件分支
将条件表达式和语句从C语言翻译成机器代码，最常用的方式是结合有条件和无条件跳转。
![2024-02-25T12:28:26.png][26]
## 3.6.6 用 条件传 送 来 实现 条件 分 支
实现条件操作的传统方法是通过使用控制的条件转移。当条件满足时，程序沿着一条执行路径执行，而当条件不满足时，就走另一条路径。这种机制简单而通用，但是在现代处理器上，它可能会非常低效。
一种替代策略是使用数据的条件转移。这种方法计算一个条件操作的两种结果，然后再根据条件是否满足从中选取一个。
如下代码：它既计算了y-x,也计算了x-y,分别命名为rval和eval。然后它再测试x是否大于等于y如果是就在函数返回rval前,将 eval复制到rval 中。![2024-02-25T12:45:52.png][27]
### 为什么性能更好？
处理器通过使用流水线(pipelining)来获得高性能,在流水线中,一条 指令 的 处理要 经 过 一 系列 的 阶段 ,每个阶段执行 所 需 操 作 的 一 小 部 分 ，通过 重叠连续指令 的步骤 来获得 高 性 能,例 如,在 取 一 条 指令 的 同时,执行它前 面一条 指令 的 算术 运算。需要够事先 确定要 执行 的 指令 序列,这样 才能 保持 流水线中 充满了待 执 行 的 指令。当 机 器 遇 到 条 件 跳 转(也 称为“分 支“）时,只有 当 分 支 条 件 求 值完成 之 后 ,才 能 决定分 支往哪 边 走。
### 条件传送指令
每条指令都有两个操作数，源寄存器或内存地址S，以及目的寄存器D。类似于不同的SET指令（见3.6.2节）和跳转指令（见3.6.3节），这些指令的结果取决于条件码的值。源值可以从内存或者源寄存器中读取，但只有在指定的条件满足时，才会被复制到目的寄存器中。
源和目的的值可以是16位、32位或64位长。不支持单字节的条件传送。汇编器可以从目标寄存器的名字推断出条件传送指令的操作数长度，因此可以使用同一个指令名字来处理所有的操作数长度。
![2024-02-25T13:18:17.png][28]
## 3.6.7 循环
### do-while循环
![2024-02-25T13:51:59.png][29]![2024-02-25T13:52:31.png][30]
### while循环
![2024-02-25T13:47:45.png][31]
跳 转 到 中间 (jump to middle), 它执行 一 个无条件跳 转跳到 循环结尾处的测试,以 此 来执行 初始 的测试 。
![2024-02-25T13:48:49.png][32]
guarded-do, 首 先 用 条件 分 支 , 如 果 初始 条件 不 成 立，就跳 过循环,把代码 变换为 do-while 循环。
![2024-02-25T13:49:45.png][33]![2024-02-25T13:49:58.png][34]
### for循环
![2024-02-25T13:43:31.png][35]
跳转到中间策略
![2024-02-25T13:45:21.png][36]
guarded-do策略
![2024-02-25T13:46:30.png][37]
# 3.6.8 switch语句
`switch`（开关）语句允许根据一个整数索引值进行多重分支（multiway branching），使用跳转表（jump table）这种数据结构可以使得实现更加高效。跳转表是一个数组，表项i是一个代码段的地址，这个代码段实现了当开关索引值等于i时程序应该采取的动作。
&创建一个指向数据值的指针，而&&这个运算符创建一个指向代码位置的指针。
示例代码：
![2024-02-25T14:19:21.png][38]![2024-02-25T14:21:27.png][39]
在汇编代码中，跳转表通常以下面的方式声明：
![2024-02-25T14:25:18.png][40]
在上述示例中，.rodata表示只读数据段,.quad用于声明8字节的数据项，每个数据项表示跳转表的一个表项，这个表项存储了对应索引值的代码段的地址。.align 8保证跳转表的起始地址是8字节对齐的。

## 3.7 过程
过程P调用过程Q，Q执行后返回到P。这些动作包括下面一个或多个机制：
- 传递控制。在进入过程Q的时候，程序计数器必须被设置为Q的代码的起始地址，然后在返回时，要把程序计数器设置为P中调用Q后面那条指令的地址。
- 传递数据。P必须能够向Q提供一个或多个参数，Q必须能够向P返回一个值。
- 分配和释放内存。在开始时，Q可能需要为局部变量分配空间，而在返回前，又必须释放这些存储空间。
## 3.7.1 运行时栈
当P调用Q时，控制和数据信息添加到栈尾。当P返回时，这些信息会被释放掉。
![2024-02-26T08:01:01.png][41]
通过寄存器，过程P可以传递最多6个整数值（也就是指针和整数），但是如果Q需要更多的参数，P可以在调用Q之前在栈帧里存储好这些参数。
## 3.7.2 转移控制 
在函数P中，要控制从函数P转移到函数Q，只需简单地将程序计数器（PC）设为函数Q的代码的起始位置。这个信息是通过指令call Q来记录的。该指令会将地址A压入栈中，并将PC设置为Q的起始地址。压入的地址A被称为返回地址，是紧跟在call指令后面的那条指令的地址。
![2024-02-26T08:04:18.png][42]
![2024-02-26T08:08:19.png][43]
![2024-02-26T08:08:59.png][44]
## 3.7.3 数据传送
大部分过程间的数据传送是通过寄存器实现的。当过程P调用过程Q时，P的代码必须首先将参数复制到适当的寄存器中。如果一个函数有大于6个整型参数，超出6个的部分就要通过栈来传递。通过栈传递参数时，所有的数据大小都向8的倍数对齐。参数到位后，程序就可以执行call指令将控制转移到过程Q了。
![2024-02-26T08:23:37.png][45]
后面两个参数通过栈来传输，由于返回地址被压入栈中。因而这两个参数位于相对于栈指针距离为8和16的位置
![2024-02-26T08:24:07.png][46]
## 3.7.4 栈 上 的 局 部 存储
在 caller 的代码开始时，将栈指针减去了16；实际上，这就是在栈上分配了16个字节。最后，该函数在第11行将栈指针加16，释放栈帧。
![2024-02-26T09:14:19.png][47]
## 3.7.5 寄存器中的局部存储空间
根据惯例，寄存器%rbx、%rbp和%r12~%r15被划分为被调用者保存寄存器。当过程P调用过程Q时，Q必须保存这些寄存器的值，保证它们的值在Q返回到P时与Q被调用时是一样的。过程Q保存一个寄存器的值不变，要么就是根本不去改变它，要么就是把原始值压入栈中，改变寄存器的值，然后在返回前从栈中弹出旧值。
所有其他的寄存器，除了栈指针%rsp，都分类为调用者保存寄存器。这就意味着任何函数都能修改它们。
![2024-02-26T09:24:16.png][48]
## 3.7.6 递归过程
![2024-02-26T09:32:08.png][49]
# 3.8数组的分配和访问
## 3.8.1 基本原则
假 设E是 一个 int型的数组,而 我们 想计算 E[i], 在 此 ,E 的 地 址 存放 在 寄存器%rdx 中,而 i 存放 在寄存 器%rcx 中。然后 ,指令`movl (%rdx,%rcx,4),eax`会执行地址计算 x_E 十4i,读 这 个 内 存位 置 的 值 ,并 将 结果 存放 到 寄存 器%eax 中
## 3.8.2 指针运算
![2024-02-26T12:31:52.png][50]
## 3.8.3 嵌套的数组
通常来说，对于一个声明如下的数组：
```
T D[R][C];
```
它的数组元素$D[i][j]$的内存地址为
&D[i][j]=x_D+L(C*i+j)
## 3.8.4 定长数组
## 3.8.5 变长数组
# 3.9 异质的数据结构
## 3.9.1 结构
类似于数组的实现，结构的所有组成部分都存放在内存中一段连续的区域内，而指向结构的指针就是结构第一个字节的地址。编译器维护关于每个结构类型的信息，指示每个字段（field）的字节偏移。它以这些偏移作为内存引用指令中的位移，从而产生对结构元素的引用。
考虑这样一个结构
```c
struct rec {
int i;
int j;
int a[2];
int *p;
};
```
![2024-02-26T12:48:22.png][51]
假设 struct rec* 类型的变量 r 放在寄存器 %rdi 中，下面的代码将元素 r->i 复制到元素 r->j：
![2024-02-26T12:50:10.png][52]
只用加上偏移量8+4*1=12,就可以得到指针&(r->a[1])
![2024-02-26T12:51:01.png][53]
## 3.9.2 联合
## 3.9.3 数据对齐
许多计算机系统对基本数据类型的合法地址做出了一些限制，要求某种类型对象的地址必须是某个值K（通常是2、4或8）的倍数。这种对齐限制简化了形成处理器和内存系统之间的硬件设计。
![2024-02-26T13:06:47.png][54]![2024-02-26T13:08:19.png][55]


  [1]: https://image.200502.xyz/i/2025/01/29/ox9666-0.webp
  [2]: https://image.200502.xyz/i/2025/01/29/oxa0a8-0.webp
  [3]: https://image.200502.xyz/i/2025/01/29/oxauw8-0.webp
  [4]: https://image.200502.xyz/i/2025/01/29/oxbni3-0.webp
  [5]: https://image.200502.xyz/i/2025/01/29/oxcdth-0.webp
  [6]: https://image.200502.xyz/i/2025/01/29/oxdsrj-0.webp
  [7]: https://image.200502.xyz/i/2025/01/29/oxerb6-0.webp
  [8]: https://image.200502.xyz/i/2025/01/29/oxfheb-0.webp
  [9]: https://image.200502.xyz/i/2025/01/29/oxg5ya-0.webp
  [10]: https://image.200502.xyz/i/2025/01/29/oxgw15-0.webp
  [11]: https://image.200502.xyz/i/2025/01/29/oxhq54-0.webp
  [12]: https://image.200502.xyz/i/2025/01/29/oxidv3-0.webp
  [13]: https://image.200502.xyz/i/2025/01/29/oxjdrn-0.webp
  [14]: https://image.200502.xyz/i/2025/01/29/oxk0y8-0.webp
  [15]: https://image.200502.xyz/i/2025/01/29/oxknhh-0.webp
  [16]: https://image.200502.xyz/i/2025/01/29/oxu1c7-0.webp
  [17]: https://image.200502.xyz/i/2025/01/29/oxutdc-0.webp
  [18]: https://image.200502.xyz/i/2025/01/29/oxvfua-0.webp
  [19]: https://image.200502.xyz/i/2025/01/29/oxwa73-0.webp
  [20]: https://image.200502.xyz/i/2025/01/29/oxxaov-0.webp
  [21]: https://image.200502.xyz/i/2025/01/29/oxydv7-0.webp
  [22]: https://image.200502.xyz/i/2025/01/29/oxz1y9-0.webp
  [23]: https://image.200502.xyz/i/2025/01/29/oxzsbe-0.webp
  [24]: https://image.200502.xyz/i/2025/01/29/oy0ke9-0.webp
  [25]: https://image.200502.xyz/i/2025/01/29/oy17k3-0.webp
  [26]: https://image.200502.xyz/i/2025/01/29/oy2bnx-0.webp
  [27]: https://image.200502.xyz/i/2025/01/29/oy2xif-0.webp
  [28]: https://image.200502.xyz/i/2025/01/29/oy41o6-0.webp
  [29]: https://image.200502.xyz/i/2025/01/29/oy4rsx-0.webp
  [30]: https://image.200502.xyz/i/2025/01/29/oy5iy5-0.webp
  [31]: https://image.200502.xyz/i/2025/01/29/oy61xe-0.webp
  [32]: https://image.200502.xyz/i/2025/01/29/oyfiw4-0.webp
  [33]: https://image.200502.xyz/i/2025/01/29/oyg4r2-0.webp
  [34]: https://image.200502.xyz/i/2025/01/29/oyh0hj-0.webp
  [35]: https://image.200502.xyz/i/2025/01/29/oyhm7i-0.webp
  [36]: https://image.200502.xyz/i/2025/01/29/oyi9hy-0.webp
  [37]: https://image.200502.xyz/i/2025/01/29/oyiyf7-0.webp
  [38]: https://image.200502.xyz/i/2025/01/29/oyjsg2-0.webp
  [39]: https://image.200502.xyz/i/2025/01/29/oykdwu-0.webp
  [40]: https://image.200502.xyz/i/2025/01/29/oyl3g1-0.webp
  [41]: https://image.200502.xyz/i/2025/01/29/oym3of-0.webp
  [42]: https://image.200502.xyz/i/2025/01/29/oymowt-0.webp
  [43]: https://image.200502.xyz/i/2025/01/29/oyne7p-0.webp
  [44]: https://image.200502.xyz/i/2025/01/29/oyoftx-0.webp
  [45]: https://image.200502.xyz/i/2025/01/29/oyp45v-0.webp
  [46]: https://image.200502.xyz/i/2025/01/29/oypzim-0.webp
  [47]: https://image.200502.xyz/i/2025/01/29/oyqryq-0.webp
  [48]: https://image.200502.xyz/i/2025/01/29/oyrq2y-0.webp
  [49]: https://image.200502.xyz/i/2025/01/29/oz126u-0.webp
  [50]: https://image.200502.xyz/i/2025/01/29/oz1wot-0.webp
  [51]: https://image.200502.xyz/i/2025/01/29/oz2nya-0.webp
  [52]: https://image.200502.xyz/i/2025/01/29/oz33pe-0.webp
  [53]: https://image.200502.xyz/i/2025/01/29/oz3lvc-0.webp
  [54]: https://image.200502.xyz/i/2025/01/29/oz4lcd-0.webp
  [55]: https://image.200502.xyz/i/2025/01/29/oz5sx8-0.webp