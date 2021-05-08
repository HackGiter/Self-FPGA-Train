`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 10:23:44
// Design Name: 
// Module Name: rshift_register
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


module rshift_register(
//in,
//out,
//clk,
//dout,
//clr
in,
clk,
clr,
q1,
q2,
q3,
q4,
out
    );
//    input in, clk, clr;
//    output[3:0] out;
//    output dout;
//    reg[3:0] out;
//    reg dout;
//    always @(posedge clk or posedge clr)
//    if (~clr)
//    begin
//    dout <= out[3];
//    out <= out << 1;
//    if (in) out = out + in;
//    end
//    else out <= 0;
    output q1, q2, q3, q4, out;
    input in, clk, clr;
    reg q1, q2, q3, q4, out;
    always @(posedge clk or posedge clr)
    if (clr)
    begin
        q1<=0;
        q2<=0;
        q3<=0;
        q4<=0;
    end
    else
    begin
        out <= q4;
        q4<=q3;
        q3<=q2;
        q2<=q1;
        q1<=in;
//        if (in) q1<=in;
//        else q1<=0;
    end
endmodule
