`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 22:14:57
// Design Name: 
// Module Name: seg_dynamic
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

//������
module seg_dynamic(
input wire clk , //ϵͳʱ�ӣ�Ƶ��50MHz
input wire rst , //��λ�źţ�����Ч
input wire [12:0] data , //�����Ҫ��ʾ��ֵ
input wire seg_en , //�����ʹ���źţ��ߵ�ƽ��Ч
input wire sign , //����λ���ߵ�ƽ��ʾ����
output reg [3:0] sel , //�����λѡ�ź�
output reg [7:0] seg //����ܶ�ѡ�ź�
  );
reg [3:0] point=4'b0000; //С������ʾ,�ߵ�ƽ��Ч
//parameter define
parameter CNT_MAX = 16'd49_999; //�����ˢ��ʱ��������ֵ
//parameter CNT_MAX = 18'd99_999;
//wire define
wire [3:0] unit ; //��λ��
wire [3:0] ten ; //ʮλ��
wire [3:0] hun ; //��λ��
wire [3:0] tho ; //ǧλ��
//reg define
reg [15:0] data_reg ; //����ʾ���ݼĴ���
reg [15:0] cnt_1ms ; //1ms������
reg flag_1ms ; //1ms��־�ź�
reg [2:0] cnt_sel ; //�����λѡ������
reg [3:0] sel_reg ; //λѡ�ź�
reg [3:0] data_disp ; //��ǰ�������ʾ������
reg dot_disp ; //��ǰ�������ʾ��С����
////
//\* Main Code \//
////
//data_reg�������������ʾ����
always@(posedge clk or posedge rst)
if(rst == 1'b1)
data_reg <= 24'b0;
//4'd10���Ƕ���Ϊ��ʾ����
//4'd11���Ƕ���Ϊ����ʾ
//����ʾ��ʮ��������ǧλΪ�������ݻ�����ʾС���㣬��ֵ��ʾ4�������
else if(((tho) || (point[3])) && (sign == 1'b1))
data_reg <= {4'd11,4'd10,tho,hun,ten,unit};
else if(((tho) || (point[3])) && (sign == 1'b0))
data_reg <= {4'd11,4'd11,tho,hun,ten,unit};
//����ʾ��ʮ�������İ�λΪ�������ݻ�����ʾС���㣬��ֵ��ʾ3�������
else if(((hun) || (point[2])) && (sign == 1'b1))
data_reg <= {4'd11,4'd11,4'd10,hun,ten,unit};
else if(((hun) || (point[2])) && (sign == 1'b0))
data_reg <= {4'd11,4'd11,4'd11,hun,ten,unit};
//����ʾ��ʮ��������ʮλΪ�������ݻ�����ʾС���㣬��ֵ��ʾ2�������
else if(((ten) || (point[1])) && (sign == 1'b1))
data_reg <= {4'd11,4'd11,4'd11,4'd10,ten,unit};
else if(((ten) || (point[1])) && (sign == 1'b0))
data_reg <= {4'd11,4'd11,4'd11,4'd11,ten,unit};
//����ʾ��ʮ�������ĸ�λ������ʾ����
else if(((unit) || (point[0])) && (sign == 1'b1))
data_reg <= {4'd11,4'd11,4'd11,4'd11,4'd10,unit};
//�����涼�����㶼ֻ��ʾһλ�����

else
data_reg <= {4'd11,4'd11,4'd11,unit};
//cnt_1ms:1msѭ������
always@(posedge clk or posedge rst)
if(rst == 1'b1)
cnt_1ms <= 16'd0;
else if(cnt_1ms == CNT_MAX)
cnt_1ms <= 16'd0;
else
cnt_1ms <= cnt_1ms + 1'b1;
//flag_1ms:1ms��־�ź�
always@(posedge clk or posedge rst)
if(rst == 1'b1)
flag_1ms <= 1'b0;
else if(cnt_1ms == CNT_MAX - 1'b1)
flag_1ms <= 1'b1;
else
flag_1ms <= 1'b0;
//cnt_sel����0��3ѭ����������ѡ��ǰ��ʾ�������
always@(posedge clk or posedge rst)
if(rst == 1'b1)
cnt_sel <= 3'd0;
else if((cnt_sel == 3'd3) && (flag_1ms == 1'b1))
 cnt_sel <= 3'd0;
 else if(flag_1ms == 1'b1)
 cnt_sel <= cnt_sel + 1'b1;
 else
 cnt_sel <= cnt_sel;

 //�����λѡ�źżĴ���
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 sel_reg <= 4'b0000;
 else if((cnt_sel == 3'd0) && (flag_1ms == 1'b1))
 sel_reg <= 4'b0001;
 else if(flag_1ms == 1'b1)
 sel_reg <= sel_reg << 1;
 else
 sel_reg <= sel_reg;

 //��������ܵ�λѡ�źţ�ʹ4�������������ʾ
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 data_disp <= 4'b0;
 else if((seg_en == 1'b1) && (flag_1ms == 1'b1))
 case(cnt_sel)
 3'd0: data_disp <= data_reg[3:0] ; //����1������ܸ���λֵ
 3'd1: data_disp <= data_reg[7:4] ; //����2������ܸ�ʮλֵ
 3'd2: data_disp <= data_reg[11:8] ; //����3������ܸ���λֵ
 3'd3: data_disp <= data_reg[15:12]; //����4������ܸ�ǧλֵ
 default:data_disp <= 4'b0;
 endcase
 else
 data_disp <= data_disp;

 //dot_disp��С����͵�ƽ���������С������Ч�ź�ȡ��
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 dot_disp <= 1'b1;
 else if(flag_1ms == 1'b1)
 dot_disp <= ~point[cnt_sel];
 else
 dot_disp <= dot_disp;

 //��������ܶ�ѡ�źţ���ʾ����
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 seg <= 8'b1111_1111;
 else
 case(data_disp)
 4'd0 : seg <= {dot_disp,7'b100_0000}; //��ʾ����0
 4'd1 : seg <= {dot_disp,7'b111_1001}; //��ʾ����1
 4'd2 : seg <= {dot_disp,7'b010_0100}; //��ʾ����2
 4'd3 : seg <= {dot_disp,7'b011_0000}; //��ʾ����3
 4'd4 : seg <= {dot_disp,7'b001_1001}; //��ʾ����4
 4'd5 : seg <= {dot_disp,7'b001_0010}; //��ʾ����5
 4'd6 : seg <= {dot_disp,7'b000_0010}; //��ʾ����6
 4'd7 : seg <= {dot_disp,7'b111_1000}; //��ʾ����7
 4'd8 : seg <= {dot_disp,7'b000_0000}; //��ʾ����8
 4'd9 : seg <= {dot_disp,7'b001_0000}; //��ʾ����9
 4'd10 : seg <= 8'b1011_1111 ; //��ʾ����
 4'd11 : seg <= 8'b1111_1111 ; //����ʾ�κ��ַ�
 default:seg <= 8'b1100_0000;
 endcase

 //sel:�����λѡ�źŸ�ֵ
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 sel <= 4'b0000;
 else
 sel <= sel_reg;

 ////
 //\* Instantiation \//
 ////

 //---------- bsd_8421_inst ----------
 bcd_8421 bcd_8421_inst
 (
 .clk (clk ), //ϵͳʱ�ӣ�Ƶ��50MHz
 .rst (rst), //��λ�źţ��͵�ƽ��Ч
 .data (data ), //������Ҫת��������

 .unit (unit ), //��λBCD��
 .ten (ten ), //ʮλBCD��
 .hun (hun ), //��λBCD��
 .tho (tho ) //ǧλBCD��
 );
 endmodule