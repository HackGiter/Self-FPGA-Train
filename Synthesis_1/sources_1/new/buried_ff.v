`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 09:41:04
// Design Name: 
// Module Name: buried_ff
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


module buried_ff(
c,
b,
a
    );
    output c;
    input a, b;
    reg c;
    always @(a or b)
        begin
            if ((a==1)&&(b==1)) c = a & b;
            else c = 0;
        end
endmodule
