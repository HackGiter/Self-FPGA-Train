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


module full_add1(
a,
b,
cin,
sum,
cout
    );
    input a, b, cin;
    output sum, cout;
    wire s1, m1, m2, m3;
    and (m1, a, b),
        (m2, b, cin),
        (m3, a, cin);
    xor (s1, a, b),
        (sum, s1, cin);
    or (cout, m1, m2, m3);
    
endmodule
