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
    input A, B, C, D;   //����˿�
    output F;   //����˿�
    //����һ��˫��˿�
    wire A, B, C, D;    //�����źŵ���������(wire�����ͺ�reg�Ĵ����ͣ�Ĭ��wire)
        assign F = ~((A&B)|(C&D));
endmodule
