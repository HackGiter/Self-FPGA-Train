`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 15:03:59
// Design Name: 
// Module Name: adder4_tp
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


module adder4_tp;   //����ģ������
reg[3:0] a, b;  //���������źŶ���Ϊreg��
reg cin;
wire[3:0] sum;  //��������źŶ���Ϊwire��
wire cout;
integer i, j;
adder4 adder(cout, sum, a, b, cin); //���ò��Զ���

always #5 cin =~ cin;   //�趨cin��ȡֵ

initial
begin
a=0;b=0;cin=0;
for (i=1;i<16;i=i+1)
#10 a=i;    //�趨aȡֵ
end 

initial
begin
for (j=1;j<16;j=j+1)
#10 b=j;    //�趨bȡֵ
end

initial
begin
$monitor($time,,,"%d + %d + %b = {%b, %d}", a, b, cin, cout, sum);
#160 $finish;
end


endmodule
