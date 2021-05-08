`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 21:45:48
// Design Name: 
// Module Name: modulev_rams_16
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


module modulev_rams_16(
clka,clkb,ena,enb,wea,web,addra,addrb,dia,dib,doa,dob
    );
input clka,clkb,ena,enb,wea,web;
input [9:0] addra,addrb;
input [15:0] dia,dib;
output [15:0] doa,dob;
reg[15:0] ram [1023:0];
reg[15:0] doa,dob;

always @(posedge clka) 
if (ena)
begin
if (wea)
ram[addra] <= dia;
doa <= ram[addra];
end

always @(posedge clkb) 
if (enb)
begin
if (web)
ram[addrb] <= dib;
dob <= ram[addrb];
end


endmodule
