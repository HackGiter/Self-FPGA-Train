`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 08:57:24
// Design Name: 
// Module Name: test_t
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


module test_t;
    reg A, B, C;
    initial
    begin
        A=0;B=1;C=0;
        #50 A=1;B=0;
        #50 A=0;C=1;
        #50 B=1;
        #50 B=0;C=0;
        #50 $finish;
    end
endmodule
