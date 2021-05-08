`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 11:16:55
// Design Name: 
// Module Name: music_A
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


module music_A(
clk, speaker
    );
    input clk;
    output speaker;
    
    reg [3:0] counter;
    
    initial
    begin
    counter <= 0;
    end
    
    always @(posedge clk) if (counter == 15 ) counter <= 0; else counter <= counter + 1;
    
    assign speaker = counter[3];
    
endmodule
