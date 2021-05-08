`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 21:38:01
// Design Name: 
// Module Name: alu
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
`define add 3'd0
`define minus 3'd1
`define band 3'd2
`define bor 3'd3
`define bnot 3'd4

module alu(
out,
opcode,
a,
b
    );
    output[7:0] out;
    reg[7:0] out;
    input[2:0] opcode;
    input[7:0] a, b;
    always @(opcode or a or b)
        begin
            case(opcode)
            `add: out = a + b;
            `minus: out = a - b;
            `band: out = a & b;
            `bor: out = a | b;
            `bnot: out = ~a;
            default: out = 8'hx;
            endcase
        end
endmodule
