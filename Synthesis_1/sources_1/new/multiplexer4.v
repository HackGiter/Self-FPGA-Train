`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 23:41:25
// Design Name: 
// Module Name: multiplexer4
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


module multiplexer4(
out,
in1,
in2,
in3,
in4,
select
    );
    input in1, in2, in3, in4;
    input[1:0] select;
    output out;
    wire in1, in2, in3, in4, out;
    assign out = (select==2'b00) ? in1 : ((select==2'b01) ? in2 : ((select==2'b10) ? in3 : in4 ));
endmodule
