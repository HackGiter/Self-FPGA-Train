`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 11:12:26
// Design Name: 
// Module Name: alutask
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


module alutask(
code,
a,
b,
c
    );
    input[1:0] code;
    input[3:0] a, b;
    output[4:0] c;
    reg[4:0] c;
    
    task myhand;
    input[3:0] a, b;
    output[4:0] out;
    out = a & b;
    endtask
    
    always @(code or a or b)
    begin
    case (code)
    2'b00:myhand(a, b, c);
    2'b01:c=a|b;
    2'b10:c=a-b;
    2'b11:c=a+b;
    endcase
    end
endmodule
