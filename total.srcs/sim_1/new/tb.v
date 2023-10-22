`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 21:09:31
// Design Name: 
// Module Name: tb
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


module tb();
reg clk;
reg rst;
reg [12:0] data;
wire [3:0] unit; //��λBCD��
wire [3:0] ten; //ʮλBCD��
wire [3:0] hun; //��λBCD��
wire [3:0] tho;  //ǧλBCD��

 bcd_8421 bcd_8421(
    .rst(rst),
    .clk(clk),
	.data (data),
	.unit(unit),
	.ten(ten),
	.hun(hun),
	.tho(tho)
);
parameter Time=4;
    always begin
        clk=1'b0;
        # Time
        clk=1'b1;
        # Time;
    end
    
    initial begin
        rst=1;
        # 8
        rst=0;
    end
initial begin
	data = 13'd5000; //ʮ����165
	#1000
	data = 13'd4995; //ʮ����240
	#1000
	data = 13'd1234;	//ʮ����255
	#1000;
	$finish;
end


endmodule
