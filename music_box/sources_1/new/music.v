`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 10:11:25
// Design Name: 
// Module Name: music
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


module music(
clk, 
speaker
    );
    input clk;
    output speaker;
    
    // clk runs at 25 MHz
    reg [3:0] counter;
    
    initial
    begin
    counter <= 0;
    end
    
    always @(posedge clk) 
    begin
    counter <= counter + 1;
    end
    
    // and use the most significant bit (MSB) of the counter to drive the speaker
    assign speaker = counter[3];
endmodule
