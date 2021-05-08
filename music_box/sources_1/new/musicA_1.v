`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 11:46:07
// Design Name: 
// Module Name: musicA_1
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


module musicA_1(
clk, speaker
    );
    input clk;
    output speaker;
    
    reg [2:0] counter;
    reg speaker;
    
    initial
    begin
    counter <= 0;
    speaker <= 0;
    end
    
    always @(posedge clk) if (counter == 7) counter <= 0; else counter <= counter + 1;

    always @(posedge clk) if (counter == 7) speaker <= ~speaker;
    
endmodule
