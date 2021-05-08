`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 11:56:20
// Design Name: 
// Module Name: longframe2
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


module longframe2(
clk, strb
    );
     parameter delay = 8;
    input clk;
    output strb;
    reg strb;
    reg temp;
    reg[7:0] counter;
    always @(posedge clk)
        begin
            if (counter==255) counter = 0;
            else counter = counter - 1;
        end
    always @(posedge clk)
        begin
        strb = temp;
        end
    always @(counter)
        begin
        if (counter<=(delay-1)) temp = 1;
        else temp = 0;
        end
    
endmodule
