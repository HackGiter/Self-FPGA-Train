`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 00:00:03
// Design Name: 
// Module Name: count8
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


module count8(
out,
reset,
clk,
check
    );
 output[7:0] out;
 output check;
 input reset, clk;
 reg[7:0] out;
 reg check;
 always @(posedge clk)
    begin
    if (reset) out <= 0;    //同步复位
//    else if (out == 8'hff) out = 0;
//    else out<=out+1;    //计数
    else {check, out} = out + 1;
    end
endmodule
