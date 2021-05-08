`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 14:34:20
// Design Name: 
// Module Name: mux_1a
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


module mux_1a(
out,
in1,
in2,
in3,
in4,
cntrl1,
cntrl2
    );
    output out;
    input in1, in2, in3, in4, cntrl1, cntrl2;
//    wire notcntrl1, notcntrl2, w, x, y, z;
//    not (notcntrl1, cntrl1),
//        (notcntrl2, cntrl2);
//    and (w, in1, notcntrl1, notcntrl2),
//        (x, in2, notcntrl1, cntrl2),
//        (y, in3, cntrl1, notcntrl2),
//        (z, in4, cntrl1, cntrl2);
//    or (out, w, x, y, z);
    assign out = cntrl1 ? (cntrl2 ? in4:in3):(cntrl2 ? in2:in1);
endmodule
