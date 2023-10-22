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
input wire clk , //ϵͳʱ��,50MHz
input wire rst , //��λ�źţ�����Ч
input wire [7:0] adc_data , //AD��������
input wire but,
output wire ad_clk,//AD����ʱ��,���֧��20Mhzʱ��
//output wire [12:0] max, //����ת�����max��ѹֵ
output wire [3:0] sel, //�����λѡ�ź�
output wire [7:0] seg //����ܶ�ѡ�ź�
);
//wire [12:0] max; //����ת�����max��ѹֵ
wire [12:0] vrms;
//------------- adc_inst -------------
voltmeter2 voltmeter2_inst
(
.clk (clk ), //ʱ��
.rst (rst ), //��λ�źţ��͵�ƽ��Ч
.adc_data (adc_data ), //AD��������

.ad_clk (ad_clk ),//AD����ʱ��,���֧��20Mhzʱ��
//.max(max)
.vrms(vrms),
.but(but)
//.sign (sign ), //��������λ
//.volt (volt ) //����ת����ĵ�ѹֵ
);
//------------- seg_595_dynamic_inst --------------
seg_595_dynamic seg_595_dynamic_inst
(
.clk (clk ), //ϵͳʱ�ӣ�Ƶ��50MHz
.rst (rst), //��λ�źţ�����Ч
.data (vrms), //�����Ҫ��ʾ��ֵ
.seg_en (1'b1 ), //�����ʹ���źţ��ߵ�ƽ��Ч
.sign (1'b0 ), //����λ���ߵ�ƽ��ʾ����
.sel(sel),
.seg(seg)
//point
//.stcp (stcp ), //������ݴ洢��ʱ��
//.shcp (shcp ), //��λ�Ĵ�����ʱ������
//.ds (ds ), //������������
//.oe (oe ) //���ʹ���ź�
);
endmodule
