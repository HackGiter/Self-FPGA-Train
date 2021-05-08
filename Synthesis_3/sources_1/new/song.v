`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 10:26:55
// Design Name: 
// Module Name: song
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


module song(
clk_6MHz, clk_4Hz, speaker, high, med, low, rst
    );
    input clk_6MHz, clk_4Hz, rst;
    output speaker;
    output[3:0] high, med, low;
    reg[3:0] high, med, low;
    reg[13:0] divider, origin;
    reg[7:0] counter;
    reg speaker;
    wire carry;
    
    always @(posedge rst)
        begin
            speaker = 0;
            counter = 0;
            divider = 0;
        end
    
    assign carry = (divider==16383);
    
    always @(posedge clk_6MHz)
        begin
            if (carry) divider = origin;
            else divider = divider + 1;
        end
     
     always @(posedge carry)
        begin
            speaker = ~ speaker;
        end
      
     always @(posedge clk_4Hz)
        begin
            case ({high, med, low})
            'b0000_0000_0011:origin= 7281;
            'b0000_0000_0101:origin= 8730;
            'b0000_0000_0110:origin= 9565;
            'b0000_0000_0111:origin= 10310;
            'b0000_0001_0000:origin= 10647;
            'b0000_0010_0000:origin= 11272;
            'b0000_0011_0000:origin= 11831;
            'b0000_0101_0000:origin= 12556;
            'b0000_0110_0000:origin= 12974;
            'b0001_0000_0000:origin= 13516;
            'b0000_0000_0000:origin= 16383;
            endcase
        end
     
     always @(posedge clk_4Hz)
        begin
            if (counter == 63) counter = 0;
            else counter = counter + 1;
            case (counter)
            0: {high, med, low} = 'b0000_0000_0011;
            1: {high, med, low} = 'b0000_0000_0011;
            2: {high, med, low} = 'b0000_0000_0011;
            3: {high, med, low} = 'b0000_0000_0011;
            4: {high, med, low} = 'b0000_0000_0101;
            5: {high, med, low} = 'b0000_0000_0101;
            6: {high, med, low} = 'b0000_0000_0101;
            7: {high, med, low} = 'b0000_0000_0110;
            8: {high, med, low} = 'b0000_0001_0000;
            9: {high, med, low} = 'b0000_0001_0000;
            10: {high, med, low} = 'b0000_0001_0000;
            11: {high, med, low} = 'b0000_0010_0000;
            12: {high, med, low} = 'b0000_0000_0110;
            13: {high, med, low} = 'b0000_0001_0000;
            14: {high, med, low} = 'b0000_0000_0101;
            15: {high, med, low} = 'b0000_0000_0101;
            endcase
        end
        
        
endmodule
