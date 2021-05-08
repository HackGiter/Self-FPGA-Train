`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 10:19:20
// Design Name: 
// Module Name: music_1_tb
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


module music_1_tb(

    );
    reg clk;
    wire speaker;
    reg clka;
    wire speakera;
    reg clka_1;
    wire speakera_1;
    reg clka_2;
    wire speakera_2;
    
    music music(clk, speaker);
    music_A music_A(clka, speakera);
    musicA_1 musicA_1(clka_1, speakera_1);
    musicA_2 musicA_2(clka_2, speakera_2);
    
    always #5 clk =~ clk; // 5ns变换一次 频率f=1/t
    always #5 clka =~ clka;
    always #5 clka_1 =~ clka_1;
    always #5 clka_2 =~ clka_2;
    
    initial
    begin
    clk = 0;
    clka = 0;
    clka_1 = 0;
    clka_2 = 0;
    # (5*100) $finish;
    end
    
endmodule
