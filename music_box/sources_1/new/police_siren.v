`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 15:15:35
// Design Name: 
// Module Name: police_siren
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


module police_siren(
clk, speaker
    );
    input clk;
    output speaker;
    
    reg [22:0] tone;
    initial
    begin
    tone <= 0;
    end
    always @(posedge clk) tone <= tone + 1;
    
    wire [6:0] ramp = (tone[22]?tone[21:15]:~tone[21:15]);
    wire [14:0] clkdivider = {2'b01, ramp, 6'b000000};
    
    reg [14:0] counter;
    initial
    begin
    counter <= 0;
    end
    always @(posedge clk) if (counter==0) counter <= clkdivider; else counter <= counter -1;
    
    reg speaker;
    initial
    begin
    speaker <= 0;
    end
    always @(posedge clk) if (counter==0) speaker <= ~speaker;
    
    
endmodule
