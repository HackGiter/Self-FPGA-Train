`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 15:26:03
// Design Name: 
// Module Name: fre_ctrl
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


module fre_ctrl(
clk,
rst,
count_en,
count_clr,
load
    );
    output count_en, count_clr, load;
    input clk, rst;
    reg count_en, load;
    always @(posedge clk or posedge rst)
        begin
            if (rst) begin count_en = 0; load = 1; end
            else begin count_en = ~ count_en; load = ~ count_en; end
        end
    assign count_clr = ~ clk & load;
endmodule
