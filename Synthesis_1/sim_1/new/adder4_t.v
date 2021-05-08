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


module adder4_tp;   //测试模块名称
reg[3:0] a, b;  //测试输入信号定义为reg型
reg cin;
wire[3:0] sum;  //测试输出信号定义为wire型
wire cout;
integer i, j;
adder4 adder(cout, sum, a, b, cin); //调用测试对象

always #5 cin =~ cin;   //设定cin的取值

initial
begin
a=0;b=0;cin=0;
for (i=1;i<16;i=i+1)
#10 a=i;    //设定a取值
end 

initial
begin
for (j=1;j<16;j=j+1)
#10 b=j;    //设定b取值
end

initial
begin
$monitor($time,,,"%d + %d + %b = {%b, %d}", a, b, cin, cout, sum);
#160 $finish;
end


endmodule
