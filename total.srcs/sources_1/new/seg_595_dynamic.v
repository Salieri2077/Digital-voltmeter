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
input wire clk , //ϵͳʱ�ӣ�Ƶ��50MHz
input wire rst , //��λ�źţ�����Ч
input wire [12:0] data , //�����Ҫ��ʾ��ֵ
input wire seg_en , //�����ʹ���źţ��ߵ�ƽ��Ч
input wire sign, //����λ���ߵ�ƽ��ʾ����

output wire [3:0] sel, //�����λѡ�ź�
output wire [7:0] seg //����ܶ�ѡ�ź�
 );


 seg_dynamic seg_dynamic_inst
 (
 .clk (clk ), //ϵͳʱ�ӣ�Ƶ��50MHz
 .rst (rst), //��λ�źţ�����Ч
 .data (data ), //�����Ҫ��ʾ��ֵ
 .seg_en (seg_en ), //�����ʹ���źţ��ߵ�ƽ��Ч
 .sign (sign ), //����λ���ߵ�ƽ��ʾ����

 .sel (sel ), //�����λѡ�ź�
 .seg (seg ) //����ܶ�ѡ�ź�

 );


 endmodule
