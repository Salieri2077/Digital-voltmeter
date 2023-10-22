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
input wire clk , //ϵͳʱ��,50MHz
input wire rst , //��λ�źţ�����Ч
input wire [7:0] adc_data , //AD��������

output wire ad_clk , //AD����ʱ��,���֧��20Mhzʱ��
output wire stcp , //���ݴ洢��ʱ��
output wire shcp , //��λ�Ĵ���ʱ��
output wire ds , //������������
output wire oe //ʹ���ź�
    );
////
//Internal Signal \//
////
//wire define
wire [13:0] max ; //����ת����ĵ�ѹֵ
//wire sign ; //��������λ

////
//\* Instantiation \//
////
//------------- adc_inst -------------
voltmeter2 voltmeter2_inst
(
.clk (clk ), //ʱ��
.rst (rst ), //��λ�źţ��͵�ƽ��Ч
.adc_data (ad_data ), //AD��������

.ad_clk (ad_clk ),//AD����ʱ��,���֧��20Mhzʱ��
.max(max)
//.sign (sign ), //��������λ
//.volt (volt ) //����ת����ĵ�ѹֵ
);

//------------- seg_595_dynamic_inst --------------
seg_595_dynamic seg_595_dynamic_inst
(
.clk (clk ), //ϵͳʱ�ӣ�Ƶ��50MHz
.rst (rst), //��λ�źţ�����Ч
.data (max), //�����Ҫ��ʾ��ֵ
.seg_en (1'b1 ), //�����ʹ���źţ��ߵ�ƽ��Ч
.sign (1'b0 ), //����λ���ߵ�ƽ��ʾ����
//point
.stcp (stcp ), //������ݴ洢��ʱ��
.shcp (shcp ), //��λ�Ĵ�����ʱ������
.ds (ds ), //������������
.oe (oe ) //���ʹ���ź�
);

endmodule
