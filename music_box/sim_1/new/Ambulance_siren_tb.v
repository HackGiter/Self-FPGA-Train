`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 15:00:15
// Design Name: 
// Module Name: Ambulance_siren_tb
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


module Ambulance_siren_tb(

    );
    reg clk;
    reg clk1;
    wire speaker;
    wire speaker1;
    
    Ambulance_siren as(clk, speaker);
    police_siren ps(clk1, speaker1);
    
    always #1 clk =~ clk;
    always #1 clk1 =~ clk1;
    
    initial
    begin
    clk = 0;
    clk1 = 0;
    #(1000*1000*1000) $finish;
    end
    
endmodule
