`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 14:55:22
// Design Name: 
// Module Name: Ambulance siren
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


module Ambulance_siren(
clk, speaker
    );
    input clk;
    output speaker;
    parameter clkdivider = 25000000/440/2;
    
    reg [23:0] tone;
    initial
    begin
    tone <= 0;
    end
    
    always @(posedge clk) tone <= tone + 1;
    
    reg [14:0] counter;
    initial
    begin
    counter <= 0;
    end
    
    always @(posedge clk) if (counter == 0) counter <= (tone[23] ? clkdivider-1 : clkdivider/2-1); else counter <= counter-1;
    
    reg speaker;
    initial
    begin
    speaker <= 0;
    end
    
    always @(posedge clk) if (counter == 0) speaker <= ~speaker;
    
endmodule
