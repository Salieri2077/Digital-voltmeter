`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 22:48:51
// Design Name: 
// Module Name: hc595_ctrl
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


module hc595_ctrl(
input wire clk , //ϵͳʱ�ӣ�Ƶ��50MHz
input wire rst , //��λ�źţ�����Ч
input wire [3:0] sel , //�����λѡ�ź�
input wire [7:0] seg , //����ܶ�ѡ�ź�

output reg stcp , //���ݴ洢��ʱ��
output reg shcp , //��λ�Ĵ���ʱ��
 output reg ds , //������������
 output wire oe //ʹ���źţ�����Ч
    );
////
 //\* Parameter and Internal Signal \//
 ////
 //reg define
 reg [1:0] cnt_4 ; //��Ƶ������
 reg [3:0] cnt_bit ; //����λ��������

 //wire define
 wire [11:0] data ; //������źżĴ� 8+4!

 ////
 //\* Main Code \//
 ////

 //��������źżĴ�
 assign data={seg[0],seg[1],seg[2],seg[3],seg[4],seg[5],seg[6],seg[7],sel};

 //����λȡ����ֵ���伴�� cishiweigao
 assign oe = rst;

 //��Ƶ������:0~3ѭ������
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 cnt_4 <= 2'd0;
 else if(cnt_4 == 2'd3)
 cnt_4 <= 2'd0;
 else
 cnt_4 <= cnt_4 + 1'b1;

 //cnt_bit:ÿ����һλ���ݼ�һ
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 cnt_bit <= 4'd0;
 else if(cnt_4 == 2'd3 && cnt_bit == 4'd13)
 cnt_bit <= 4'd0;
 else if(cnt_4 == 2'd3)
 cnt_bit <= cnt_bit + 1'b1;
 else
 cnt_bit <= cnt_bit;

 //stcp:14���źŴ������֮�����һ��������
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 stcp <= 1'b0;
 else if(cnt_bit == 4'd13 && cnt_4 == 2'd3)
 stcp <= 1'b1;
 else
 stcp <= 1'b0;

 //shcp:�����ķ�Ƶ��λʱ��
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 shcp <= 1'b0;
 else if(cnt_4 >= 4'd2)
 shcp <= 1'b1;
 else
 shcp <= 1'b0;

 //ds:���Ĵ�����洢��������ź����뼴
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 ds <= 1'b0;
 else if(cnt_4 == 2'd0)
 ds <= data[cnt_bit];
 else
 ds <= ds;

 endmodule
