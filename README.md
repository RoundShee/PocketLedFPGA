## 目标

目标：设计并实现一 个16*16 LED 点阵控制器项目。

实现功能如下：

(1) 控制 16*16点阵的 LED 灯以扫描的形式依次点亮；

(2) 通过 4 个按键控制亮点在点阵上的位置移动；

(3) 显示简单的设计好的图案；

(4) 显示动态可控图案；


## 想法

将需要的变换按时序行为存储到寄存器，作为子循环。

主循环为根据按键判断跳转到那个子循环。


## 分析

* 顶层      Round.v

        需要对应相应功能 可以简单设置$2^3=8$个状态，分别控制对应功能模块的使能；

        需要时钟，时钟可统一调度。进入对应功能模块后主循环停止进入保持状态等待子模块完成。

        需要按键接入，对主循环进行控制，同时子循环的模块也需要连接主循环的按键。

* 顶层子模块：菜单控制menu

        将状态作为输入，用户操作输入，根据用户操纵变换返回：顶层的调用各个子模块的状态。

        与子模块进行交互，通过en_back告诉menu子模块是否执行完毕，进而改变对子模块的控制信号en_sub

* 子模块1：扫描形式点亮

        输入：时钟、自个的使能en_sub、按键输入

        输出：点阵的控制、自个状态完成反馈


* 子模块2：控制亮点


* 子模块3：显示图案