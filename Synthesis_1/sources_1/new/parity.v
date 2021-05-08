`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 21:21:16
// Design Name: 
// Module Name: parity
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

//��żУ��λ������
module parity(
even_bit,
odd_bit,
input_bus
    );
    output even_bit, odd_bit;
    input[7:0] input_bus;
    assign odd_bit = ^input_bus;    //������У��λ
    assign even_bit = ~odd_bit; // ����żУ��λ
endmodule
