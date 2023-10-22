`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 23:28:56
// Design Name: 
// Module Name: voltmeter2
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


module voltmeter2(
input clk,
    input [7:0] adc_data,
    input rst,
    input but,
    output wire ad_clk,
    //output wire [12:0] max
    output reg[12:0] vrms
    );
//    wire [13:0] max;
    wire pro_clk;
    wire [12:0]volt;
    wire sign;//-为1
    wire [13:0] sin_wave;
        
    parameter div=5;    
    reg reg_div;
    reg[3:0] div_cnt;
    always@(posedge clk)begin
    if(rst==1'b1)begin
    reg_div<=0;
    div_cnt<=4'b0;
    end
    else if(div_cnt==(div/2)-1)begin
    div_cnt<=0;
    reg_div<=~reg_div;
    end
    else div_cnt<=div_cnt+1;
    end
    parameter show_div=25000;
    wire show_clk;
    reg [7:0] addata;
    
    //reg [12:0]reg_max;
    always@(posedge ad_clk)begin
        addata<=adc_data;//上升沿读入。原因是ADC下降沿采样
    end      
    parameter medial=127;
    //只能表示整数 最后右移7位再除去128
    parameter ne=5000;    //5000*128*128;
    parameter po=5000;      //5000*128*128;
    reg [19:0] v;
    reg[12:0] reg_vol;
    reg reg_sign;
    parameter show_max=25000000;
    reg[24:0] show_cnt;
    //reg[13:0] reg_sinwave;
    always@(posedge ad_clk or posedge rst)begin
    if(rst==1) begin 
        reg_vol<=13'b0;
        //reg_max<=13'b0;  
        vrms<=13'b0;
        show_cnt<=25'd0;
    end
    else if(addata<8'd128)begin
        reg_sign<=1;
        v=(medial-addata);
        //reg_vol<=(v*ne)>>7;//例如输入adc_data=11111111,则应该是5000
        if(show_cnt==show_max-1)begin
            if(but==0)//0 is 1V
                vrms<=(v*ne)>>7;
            else if(but==1) vrms<=(v*ne*10)>>7;
            show_cnt<=25'd0;
            end
        else show_cnt<=show_cnt+1;
        //if((reg_max<((v*ne)>>7)&&(((v*ne)>>7)-reg_max<24'd100)&&(((v*ne)>>7)<24'd5002))&&((((v*ne)>>7))!=24'd1914)&&((((v*ne)>>7))!=24'd625)&&((((v*ne)>>7))!=24'd2539))
            //reg_max=(v*ne)>>7;
           
        //显示为补码，故变为补码
        reg_vol <= (~((v*ne)>>7) + 1'b1);
        //reg_sinwave<=(~({sign,reg_vol})+1'b1);
        end
    else if(addata>=8'd128)begin
        reg_sign<=0;
        v=(addata-medial);
        reg_vol<=(v*po)>>7;
        if(show_cnt==show_max-1)begin
            if(but==0)//0 is 1V
                vrms<=(v*po)>>7;
            else if(but==1) vrms<=(v*po*10)>>7;
            show_cnt<=25'd0;
            end
        else show_cnt<=show_cnt+1;
        //if((reg_max<reg_vol)&&(reg_vol-reg_max<24'd100)&&(reg_vol<24'd5002)&&(reg_vol!=24'd1914)&&(reg_vol!=24'd625)&&(reg_vol!=24'd2539))
            //reg_max=reg_vol;
        //reg_sinwave<={sign,reg_vol};
        end
    else reg_vol<=reg_vol;
    end
    
    ila_0 ila_0 (
	.clk(ad_clk), // input wire clk
	.probe0(adc_data), // input wire [7:0]  probe0  
	.probe1(sin_wave), // input wire [13:0]  probe1
	.probe2(vrms) // input wire [12:0]  probe2
);
    assign sign = reg_sign;
    assign ad_clk=reg_div;
    assign volt=reg_vol;
    //assign max=reg_max;
    //assign sin_wave=reg_sinwave;
    assign sin_wave={sign,reg_vol};
endmodule
