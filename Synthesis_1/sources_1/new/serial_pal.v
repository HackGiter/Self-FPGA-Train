`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 08:47:58
// Design Name: 
// Module Name: serial_pal
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

//4Î»´®/²¢×ª»»Æ÷
module serial_pal(
clk, reset, en, in, out
    );
    input clk, reset, en, in;
    output[3:0] out;
    reg[3:0] out;
    always @(posedge clk)
        begin
        if (reset) out <=4'h0;
        else if (en) out <= {out, in};
        end
endmodule
