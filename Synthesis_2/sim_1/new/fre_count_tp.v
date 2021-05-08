`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 15:52:50
// Design Name: 
// Module Name: fre_count_tp
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


module fre_count_tp(

    );
    reg signal, clk, rst;
    wire[15:0] QO;
//    wire[3:0] din1, din2, din3, din4;
    parameter DELY=1000;
    //integer i, j;
    
    fre_count fc(signal, clk, rst, QO);
//   fre_count fc1(signal, clk, rst, din1, din2, din3, din4);
    
    always #(DELY/10) clk = ~clk;
    always #(DELY/100) signal = ~signal;
    
    initial
    begin
    clk = 0; signal = 0;rst = 0;
    #(DELY/200) rst = 1;
    #(DELY/200) rst = 0;
    #(DELY*20) $finish;
    end
endmodule
