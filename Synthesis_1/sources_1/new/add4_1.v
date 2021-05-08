`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 19:23:06
// Design Name: 
// Module Name: full_add1
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


module add4_1(
sum,
cout,
a, 
b,
cin
    );
    output[3:0] sum;
    output cout;
    input[3:0] a, b;
    input cin;
    
    full_add1 f0 (a[0], b[0], cin, sum[0], cin1);
    full_add1 f1 (a[1], b[1], cin1, sum[1], cin2);
    full_add1 f2 (a[2], b[2], cin2, sum[2], cin3);
    full_add1 f3 (a[3], b[3], cin3, sum[3], cout);
endmodule


