`timescale 1ns / 1ps
`include "isa.vh"
`include "global_config.vh"
`include "stddef.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 19:44:41
// Design Name: 
// Module Name: if_reg
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


module if_reg(
input   wire            clk,
input   wire            reset,
input   wire[31:0]      insn,
input   wire            stall,
input   wire            flush,
input   wire[29:0]      new_pc,
input   wire            br_taken,
input   wire[29:0]      br_addr,
output  reg [29:0]      if_pc,
output  reg [31:0]      if_insn,
output  reg             if_en
    );
    
    /*PIPELINE REGISTER*/
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            /*Asychronous Reset*/
            if_pc       <= #1 `RESET_VECTOR;
            if_insn     <= #1 `ISA_NOP;
            if_en       <= #1 `DISABLE;
        end else begin
            /*Update the pipeline Register*/
            if (stall == `DISABLE) begin
                if (flush == `ENABLE) begin
                    if_pc       <= #1 new_pc;       //refresh
                    if_insn     <= #1 `ISA_NOP;     //refresh the pipeline and update the PC to new address
                    if_en       <= #1 `DISABLE;
                end else if (br_taken == `ENABLE) begin     //branch
                    if_pc       <= #1 br_addr;      //update the PC to branch Target address
                    if_insn     <= #1 insn;         
                    if_en       <= #1 `ENABLE;
                end else begin                      //next address
                    if_pc       <= #1 if_pc + 1'd1;     //update PC to next address
                    if_insn     <= #1 insn;
                    if_en       <= #1 `ENABLE;
                end
            end
        end
    end
endmodule
