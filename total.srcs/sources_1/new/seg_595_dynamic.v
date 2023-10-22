`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 23:13:04
// Design Name: 
// Module Name: seg_595_dynamic
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


module seg_595_dynamic(
input wire clk , //系统时钟，频率50MHz
input wire rst , //复位信号，低有效
input wire [12:0] data , //数码管要显示的值
input wire seg_en , //数码管使能信号，高电平有效
input wire sign, //符号位，高电平显示负号

output wire [3:0] sel, //数码管位选信号
output wire [7:0] seg //数码管段选信号
 );


 seg_dynamic seg_dynamic_inst
 (
 .clk (clk ), //系统时钟，频率50MHz
 .rst (rst), //复位信号，低有效
 .data (data ), //数码管要显示的值
 .seg_en (seg_en ), //数码管使能信号，高电平有效
 .sign (sign ), //符号位，高电平显示负号

 .sel (sel ), //数码管位选信号
 .seg (seg ) //数码管段选信号

 );


 endmodule
