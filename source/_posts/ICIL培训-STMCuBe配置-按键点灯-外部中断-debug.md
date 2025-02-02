---
title: ICIL培训 | STMCuBe配置 按键点灯 外部中断 debug
date: 2023-11-18 17:50:27
updated: 2022-10-02 22:24:34
tags:
---
## 点灯
### 配置cubemx
配置时钟
![2023-11-18T09:49:30.png][3]
![2023-11-18T08:06:38.png][4]
配置GPIO口
将PC13选择为输出模式，在左侧配置默认电平，GPIO模式，用户标签
![2023-11-18T08:30:19.png][5]
![2023-11-18T08:07:47.png][6]
配置工程
Toolchain/IDE选择要用的软件，在code generator中勾选Generate peripheral initialization as a pair of.c/.h' files per peripheral(初始化代码生成在对应的外设文件。 如UART初始化代码生成在uart.c中)
![2023-11-18T08:11:35.png][7]
![2023-11-18T08:10:09.png][8]
### 点亮led灯
LED_GPIO_Port代表目标引脚的端口号，例如GPIOB。
LED_Pin代表目标引脚的引脚号，例如GPIO_Pin_5。
GPIO_PIN_RESET代表当前引脚的高低电平，高电平(GPIO_PIN_SET)、低电平(GPIO_PIN_RESET)。
```c
HAL_GPIO_WritePin(LED_GPIO_Port, LED_Pin, GPIO_PIN_RESET);
```
翻转引脚电平
```c
HAL_GPIO_TogglePin(LED_GPIO_Port,LED_Pin);
```
### 配置按键
将PA7设置为输入模式，并且设置为上拉
![2023-11-18T08:14:00.png][9]
![2023-11-18T08:14:37.png][10]
读取引脚电平，并点亮LED灯
```c
if(HAL_GPIO_ReadPin(GPIOA,button_Pin0)==0)
  HAL_GPIO_WritePin(LED_GPIO_Port, LED_Pin, GPIO_PIN_RESET);
```
## 中断
### 滴答计时器中断
SysTick_Handler()
1ms触发一次
### 外部中断
#### 配置cubemx
将PA7设置为GPIO_EXTI,并且在NVIC中启用中断
![2023-11-18T08:21:13.png][11]
![2023-11-18T08:26:54.png][12]
#### 按键消抖
```c
void SysTick_Handler(void)
{
    if(EXTI_flag==1)//消抖
		count++;
	if(count==20)//等待20ms
	{
		EXTI_flag=0;
		count=0;
		if(HAL_GPIO_ReadPin(GPIOA,button_Pin)==0)
		{

		}
		else if(HAL_GPIO_ReadPin(GPIOA,button_Pin)==1)
		{
	           HAL_GPIO_TogglePin(GPIOC,LED_Pin);
                }
	}
}
```
#### 外部中断的回调函数
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin);
当外部中断发生时，系统会通过传递参数的方式将触发中断的引脚信息传递给回调函数。在 HAL_GPIO_EXTI_Callback() 函数中，GPIO_Pin 是一个参数，表示触发中断的引脚。
```c
HAL_GPIO_EXTI_Callback(){
	if(GPIO_Pin==button_Pin)//判断对应中断
	{
		EXIT_flag=1;
	}
}
```
## Debug
在Keil uVision5中，如图标黄的地方即可进行debug
参考：[Keil（MDK-ARM-STM32）系列教程（八）在线调试（Ⅰ）][1]
![2023-11-18T09:57:16.png][2]

  [1]: https://blog.csdn.net/qq_38351824/article/details/82555721
  [2]: https://image.200502.xyz/i/2025/01/29/ovjxm3-0.webp
  [3]: https://image.200502.xyz/i/2025/01/29/ovkuvi-0.webp
  [4]: https://image.200502.xyz/i/2025/01/29/ovlk6q-0.webp
  [5]: https://image.200502.xyz/i/2025/01/29/ovm7dm-0.webp
  [6]: https://image.200502.xyz/i/2025/01/29/ovn6mc-0.webp
  [7]: https://image.200502.xyz/i/2025/01/29/ovnpea-0.webp
  [8]: https://image.200502.xyz/i/2025/01/29/ovogam-0.webp
  [9]: https://image.200502.xyz/i/2025/01/29/ovpbhn-0.webp
  [10]: https://image.200502.xyz/i/2025/01/29/ovpz3k-0.webp
  [11]: https://image.200502.xyz/i/2025/01/29/ovqt40-0.webp
  [12]: https://image.200502.xyz/i/2025/01/29/ovrpkk-0.webp