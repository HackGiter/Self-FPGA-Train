`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 16:11:34
// Design Name: 
// Module Name: count4
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


module count4(
out,
reset,
clk
    );
 output[3:0] out;
 input reset, clk;
 reg[3:0] out;
 always @(posedge clk)
    begin
    if (reset) out <= 0;    //同步复位
    else out<=out+1;    //计数
    end
endmodule
