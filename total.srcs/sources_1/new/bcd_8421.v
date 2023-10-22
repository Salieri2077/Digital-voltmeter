`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 20:39:24
// Design Name: 
// Module Name: bcd_8421
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


module bcd_8421(
    input clk,
    input rst,
    input[12:0] data,
    
    output reg [3:0] unit, //个位BCD码
    output reg [3:0] ten, //十位BCD码
    output reg [3:0] hun, //百位BCD码
    output reg [3:0] tho  //千位BCD码
    );
     //reg define
 reg [4:0] cnt_shift ; //移位判断计数器
 reg [36:0] data_shift ; //移位判断数据寄存器
 reg shift_flag ; //移位判断标志信号

 ////
 //\* Main Code \//
 ////

 //cnt_shift:从0到21循环计数
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 cnt_shift <= 5'd0;
 else if((cnt_shift == 5'd21) && (shift_flag == 1'b1))
 cnt_shift <= 5'd0;
 else if(shift_flag == 1'b1)
 cnt_shift <= cnt_shift + 1'b1;
 else
 cnt_shift <= cnt_shift;

 //data_shift：计数器为0时赋初值，计数器为1~20时进行移位判断操作
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 data_shift <= 36'b0;
 else if(cnt_shift == 5'd0)
 data_shift <= {24'b0,data};
 else if((cnt_shift <= 20) && (shift_flag == 1'b0))
 begin
 data_shift[23:20] <= (data_shift[23:20] > 4) ?
 (data_shift[23:20] + 2'd3) : (data_shift[23:20]);
 data_shift[27:24] <= (data_shift[27:24] > 4) ?
 (data_shift[27:24] + 2'd3) : (data_shift[27:24]);
 data_shift[31:28] <= (data_shift[31:28] > 4) ?
 (data_shift[31:28] + 2'd3) : (data_shift[31:28]);
 data_shift[35:32] <= (data_shift[35:32] > 4) ?
 (data_shift[35:32] + 2'd3) : (data_shift[35:32]);
 end
 else if((cnt_shift <= 20) && (shift_flag == 1'b1))
 data_shift <= data_shift << 1;
 else
 data_shift <= data_shift;

 //shift_flag：移位判断标志信号，用于控制移位判断的先后顺序
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 shift_flag <= 1'b0;
 else
 shift_flag <= ~shift_flag;

 //当计数器等于20时，移位判断操作完成，对各个位数的BCD码进行赋值
 always@(posedge clk or posedge rst)
 if(rst == 1'b1)
 begin
 unit <= 4'b0;
 ten <= 4'b0;
 hun <= 4'b0;
 tho <= 4'b0;
 end
 else if(cnt_shift == 5'd21)
 begin
 unit <= data_shift[23:20];
 ten <= data_shift[27:24];
 hun <= data_shift[31:28];
 tho <= data_shift[35:32];
 end
 
endmodule
