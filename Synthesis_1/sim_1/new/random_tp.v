`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 20:25:55
// Design Name: 
// Module Name: random_tp
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


module random_tp;
integer data;
integer i;
parameter delay=10;

initial $monitor($time,,,"data=%b", data);
initial begin
    for (i=0; i<=100; i=i+1)
    #delay data=$random;
end
endmodule
