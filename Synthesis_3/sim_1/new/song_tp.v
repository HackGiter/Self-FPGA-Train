`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 10:43:15
// Design Name: 
// Module Name: song_tp
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


module song_tp(

    );
    reg clk_6MHz, clk_4Hz, rst;
    wire speaker;
    wire[3:0] high, med, low;
    parameter MHz6 = 4;
    parameter Hz4 = 600;
    parameter DELY = 60000;
    
    song s(clk_6MHz, clk_4Hz, speaker, high, med, low, rst);
    
    always #(MHz6) clk_6MHz = ~ clk_6MHz;
    always #(Hz4) clk_4Hz = ~ clk_4Hz;
    
    initial
    begin
    clk_6MHz = 0;
    clk_4Hz = 0;
    rst = 0;
    #1 rst = 1;
    #1 rst = 0;
    #(DELY*20) $finish;
    end
    
    
endmodule
