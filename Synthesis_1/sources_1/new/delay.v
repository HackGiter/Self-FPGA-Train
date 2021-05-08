`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 21:02:33
// Design Name: 
// Module Name: delay
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


module delay(
out,
a,
b,
c
    );
    output out;
    input a, b, c;
    and a1(n1, a, b);
    or o1(out, c, n1);
        specify
            (a=>out)=2;
            (b=>out)=3;
            (c=>out)=1;
        endspecify
endmodule
