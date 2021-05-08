`timescale 1ns / 1ps
`include "cpu.vh"
`include "isa.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/03 21:33:09
// Design Name: 
// Module Name: gpr
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

/*general register*/
module gpr(
input   wire          clk,
input   wire          reset,
input   wire[4:0]     rd_addr_0,
output  wire[31:0]    rd_data_0,
input   wire[4:0]     rd_addr_1,
output  wire[31:0]    rd_data_1,
input   wire          we_,
input   wire[31:0]    wr_addr,
input   wire[31:0]    wr_data
    );
    reg [31:0]      gpr [31:0]; //register sequence
    integer         i;      //initialized iterator
    
    /*access request(write after read)*/
    // read port 0
    assign rd_data_0 = ((we_ == `ENABLE_) && (wr_addr == rd_addr_0)) ?
                            wr_data : gpr[rd_addr_0];
    // read port 1
    assign rd_data_1 = ((we_ == `ENABLE_) && (wr_addr == rd_addr_1)) ?
                            wr_data : gpr[rd_addr_1];
                            
    //write access
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            /*asynchronous reset*/
            for (i = 0; i < `REG_NUM; i = i + 1) begin
                gpr[i]      <= #1 `WORD_DATA_W'h0;
            end
        end else begin
            /*write access*/
            if (we_ == `ENABLE_) begin
                gpr[wr_addr] <= #1 wr_data;
            end
        end
    end 
    
endmodule
