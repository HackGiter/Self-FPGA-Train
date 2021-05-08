`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 15:35:14
// Design Name: 
// Module Name: fre_count
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


module fre_count(
signal,
clk,
rst,
QO
//din
//din1,
//din2,
//din3,
//din4
    );
    input signal, clk, rst;
    output[15:0] QO;
    //output din;
//    output[3:0] din1, din2, din3, din4;
    wire cout1, cout2, cout3, cout4, count_en, count_clr, load;
    wire[15:0] din;
    
    fre_ctrl fc(clk, rst, count_en, count_clr, load);

    count10 c1(din[3:0], cout1, count_en, count_clr, signal);

    count10 c2(din[7:4], cout2, count_en, count_clr, cout1);

    count10 c3(din[11:8], cout3, count_en, count_clr, cout2);

    count10 c4(din[15:12], cout4, count_en, count_clr, cout3);

    
    latch_16 l16(QO, din, load);
//    count10 c1(din1, cout1, count_en, count_clr, signal);

//    count10 c2(din2, cout2, count_en, count_clr, cout1);

//    count10 c3(din3, cout3, count_en, count_clr, cout2);

//    count10 c4(din4, cout4, count_en, count_clr, cout3);

    
//    count10 c1(din[3:0], cout1, count_en, count_clr, signal);
//    count10 c2(din[7:4], cout2, count_en, count_clr, cout1);
//    count10 c3(din[11:8], cout3, count_en, count_clr, cout2);
//    count10 c4(din[15:12], cout4, count_en, count_clr, cout3);
    
//    latch_16 l16(QO, din, load);
    
    
endmodule
