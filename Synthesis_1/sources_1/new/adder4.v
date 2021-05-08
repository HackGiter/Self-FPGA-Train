`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 14:46:31
// Design Name: 
// Module Name: adder4
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


module adder4(
cout,
sum,
ina,
inb,
cin

    );
output[3:0] sum;
output cout;
input[3:0] ina, inb;
input cin;
    assign {cout, sum} = ina + inb + cin;
endmodule
