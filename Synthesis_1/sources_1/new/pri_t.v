`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 20:45:00
// Design Name: 
// Module Name: pri_t
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


module pri_t(
cout,
a,
b,
cin
    );
    output cout;
    input a, b, cin;
    carry_udp cudp(cout, a, b, cin);
endmodule
