`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 15:29:28
// Design Name: 
// Module Name: count10
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


module count10(
out,
cout,
en,
clr,
clk
    );
    output[3:0] out;
    output cout;
    input en, clr, clk;
    reg[3:0] out;
    
    always @(posedge clk or posedge clr)
        begin
            if (clr) out = 0;
            else if (en)
                begin
                    if (out==9) out = 0;
                    else out = out + 1;
                end
        end
     assign cout = ((out==9)&en)?1:0;
endmodule
