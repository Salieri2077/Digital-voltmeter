`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 17:11:05
// Design Name: 
// Module Name: total
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


module total(
input wire clk , //系统时钟,50MHz
input wire rst , //复位信号，低有效
input wire [7:0] adc_data , //AD输入数据
input wire but,
output wire ad_clk,//AD驱动时钟,最大支持20Mhz时钟
//output wire [12:0] max, //数据转换后的max电压值
output wire [3:0] sel, //数码管位选信号
output wire [7:0] seg //数码管段选信号
);
//wire [12:0] max; //数据转换后的max电压值
wire [12:0] vrms;
//------------- adc_inst -------------
voltmeter2 voltmeter2_inst
(
.clk (clk ), //时钟
.rst (rst ), //复位信号，低电平有效
.adc_data (adc_data ), //AD输入数据

.ad_clk (ad_clk ),//AD驱动时钟,最大支持20Mhz时钟
//.max(max)
.vrms(vrms),
.but(but)
//.sign (sign ), //正负符号位
//.volt (volt ) //数据转换后的电压值
);
//------------- seg_595_dynamic_inst --------------
seg_595_dynamic seg_595_dynamic_inst
(
.clk (clk ), //系统时钟，频率50MHz
.rst (rst), //复位信号，低有效
.data (vrms), //数码管要显示的值
.seg_en (1'b1 ), //数码管使能信号，高电平有效
.sign (1'b0 ), //符号位，高电平显示负号
.sel(sel),
.seg(seg)
//point
//.stcp (stcp ), //输出数据存储寄时钟
//.shcp (shcp ), //移位寄存器的时钟输入
//.ds (ds ), //串行数据输入
//.oe (oe ) //输出使能信号
);
endmodule
