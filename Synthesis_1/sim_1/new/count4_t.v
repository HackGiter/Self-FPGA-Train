`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 16:21:19
// Design Name: 
// Module Name: count4_t
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


module count4_t();
reg clk, reset;
wire[3:0] out;
parameter DELY=100;

count4 mycount(out, reset, clk);

always #(DELY/2) clk = ~clk;

initial
begin
clk = 0;reset = 0;
#DELY reset = 1;
#DELY reset = 0;
#(DELY*20) $finish;
end

initial $monitor($time,,,"clk=%d reset=%d out=%d", clk, reset, out);
endmodule
