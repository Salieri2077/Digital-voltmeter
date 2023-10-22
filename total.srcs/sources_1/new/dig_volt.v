`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 23:21:57
// Design Name: 
// Module Name: dig_volt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dig_volt(
input wire clk , //系统时钟,50MHz
input wire rst , //复位信号，低有效
input wire [7:0] adc_data , //AD输入数据

output wire ad_clk , //AD驱动时钟,最大支持20Mhz时钟
output wire stcp , //数据存储器时钟
output wire shcp , //移位寄存器时钟
output wire ds , //串行数据输入
output wire oe //使能信号
    );
////
//Internal Signal \//
////
//wire define
wire [13:0] max ; //数据转换后的电压值
//wire sign ; //正负符号位

////
//\* Instantiation \//
////
//------------- adc_inst -------------
voltmeter2 voltmeter2_inst
(
.clk (clk ), //时钟
.rst (rst ), //复位信号，低电平有效
.adc_data (ad_data ), //AD输入数据

.ad_clk (ad_clk ),//AD驱动时钟,最大支持20Mhz时钟
.max(max)
//.sign (sign ), //正负符号位
//.volt (volt ) //数据转换后的电压值
);

//------------- seg_595_dynamic_inst --------------
seg_595_dynamic seg_595_dynamic_inst
(
.clk (clk ), //系统时钟，频率50MHz
.rst (rst), //复位信号，低有效
.data (max), //数码管要显示的值
.seg_en (1'b1 ), //数码管使能信号，高电平有效
.sign (1'b0 ), //符号位，高电平显示负号
//point
.stcp (stcp ), //输出数据存储寄时钟
.shcp (shcp ), //移位寄存器的时钟输入
.ds (ds ), //串行数据输入
.oe (oe ) //输出使能信号
);

endmodule
