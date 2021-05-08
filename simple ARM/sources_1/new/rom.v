`timescale 1ns / 1ps
`include "rom.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/03 08:28:03
// Design Name: 
// Module Name: rom
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


module rom(
input   wire        clk,        //clock
input   wire        reset,      //asynchronous reset
input   wire        cs_,        //chip select signal
input   wire        as_,        //address select
input   wire[10:0]  addr,       //address
output  wire[31:0]  rd_data,    //the data read
output  reg         rdy_        //ready signal   

    );
    /*Xilinx FPGA BLOCK RAM: SIGNAL PORT ROM*/
    x_s3e_sprom x_s3e_sprom (
        .clka   (clk),      //clock
        .addra  (addr),     //address
        .douta  (rd_data)   //the data read
    );
    
    /*generate the ready signal*/
    always @(posedge clk or `RESET_EDGE reset)  begin
        if (reset == `RESET_ENABLE) begin
            /*asynchronous reset*/
            rdy_ <= #1  `DISABLE_;
        end else begin
            /*generate the ready signal*/
            if ((cs_ == `ENABLE_) && (as_ == `ENABLE_)) begin
                rdy_ <= #1 `ENABLE_;
            end else begin
                rdy_ <= #1 `DISABLE_;
            end
        end
    end
    
endmodule
