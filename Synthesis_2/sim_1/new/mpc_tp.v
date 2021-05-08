`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 09:20:59
// Design Name: 
// Module Name: mpc_tp
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


module mpc_tp(

    );
    reg[17:0] instr;
    wire[8:0] out;
    
    parameter DELY=10;
    mpc m1(instr, out);
    initial begin
        instr=18'd0;
    #DELY instr=18'b00_01001101_00101111;
    #DELY instr=18'b00_11001101_11101111;
    #DELY instr=18'b01_01001101_11101111;
    #DELY instr=18'b01_01001101_00101111;
    #DELY instr=18'b10_01001101_00101111;
    #DELY instr=18'b11_11001101_00101111;
    #DELY instr=18'b00_01001101_00101111;
    #DELY $finish;
    end
    initial $monitor($time,,,"instr=%b out=%b", instr, out);
endmodule
