`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 13:49:18
// Design Name: 
// Module Name: nbit_add
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


module nbit_add(
a,
b,
cin,
sum,
cout
    );
    parameter size=4;
    input[size-1:0] a, b;
    input cin;
    output[size-1:0] sum;
    output cout;
    wire[size:0] c;
    
    genvar i;
    assign c[0] = cin;
    assign cout=c[size];
    
    generate
    for(i=0;i<size;i=i+1)
    begin
        wire n1, n2, n3;
        xor g1(n1, a[i], b[i]);
        xor g2(sum[i], n1, c[i]);
        and g3(n2, a[i], b[i]);
        and g4(n3, n1, c[i]);
        or g5(c[i+1], n2, n3);
    end
    endgenerate
endmodule
