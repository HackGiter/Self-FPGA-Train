`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 15:32:14
// Design Name: 
// Module Name: latch_16
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


module latch_16(
go, din, load
    );
    output[15:0] go;
    input[15:0] din;
    input load;
    reg[15:0] go;
    always @(posedge load)
        begin 
            go = din;
        end
endmodule
