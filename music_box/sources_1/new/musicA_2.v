`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 12:01:25
// Design Name: 
// Module Name: musicA_2
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


module musicA_2(
clk, speaker
    );
    input clk;
    output speaker;
    reg speaker;
    reg [2:0] counter;
    
    parameter clkdivider = 8;
    
    initial
    begin
    counter <= clkdivider-1;
    speaker <= 0;
    end
    
    always @(posedge clk) if (counter == 0) counter <= clkdivider-1; else counter <= counter - 1;
    
    always @(posedge clk) if (counter == 0) speaker <= ~speaker;
     
endmodule
