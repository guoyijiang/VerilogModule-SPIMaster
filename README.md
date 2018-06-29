## 概述

* 这是一个spi协议verilog实现的源码仓库，包括了源码、前仿真、FPGA工程
* Author：Guo Yijiang
* Date： 2017
* HardWare： xc7a35tftg256-1
* SoftWare：ModelSim、Vivado2016.4

## 注意

* 一个传输周期：T_clk * [HBDIV*(2*bit+1)+CSU+CSD+1]
* 参数 BITS，SPI位数，标准为8/16，但此模块可以任意
* 输入 clk, rst, start分别为时钟、高电平复位、单冲击开始使能
* 输入 dataOut，是要通过总线发出的数据
* 输出 dataIn，是通过总线接受到的数据
* 标识 working，输出模块当前工作状态，busy为1，空闲为0
* sck, sdo/sdi, cs分别接到引脚，其中sdo/sdi需要用三态门