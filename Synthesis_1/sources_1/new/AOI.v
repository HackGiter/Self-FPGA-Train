`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 18:25:08
// Design Name: 
// Module Name: AOI
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


module AOI(
A,
B,
C,
D,
F
    );
    input A, B, C, D;   //输入端口
    output F;   //输出端口
    //还有一种双向端口
    wire A, B, C, D;    //定义信号的数据类型(wire连线型和reg寄存器型，默认wire)
        assign F = ~((A&B)|(C&D));
endmodule
