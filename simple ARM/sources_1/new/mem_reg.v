`timescale 1ns / 1ps
`include "isa.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 21:16:30
// Design Name: 
// Module Name: mem_reg
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


module mem_reg(
/*Clock & Reset*/
input   wire            clk,
input   wire            reset,
/*Memory Access Result*/
input   wire[31:0]      out,
input   wire            miss_align,
/*Pipeline Control Signal*/
input   wire            stall,
input   wire            flush,
/*EX/MEM Pipeline Register*/
input   wire[29:0]      ex_pc,
input   wire            ex_en,
input   wire            ex_br_flag,
input   wire[1:0]       ex_ctrl_op,
input   wire[4:0]       ex_dst_addr,
input   wire            ex_gpr_we_,
input   wire[2:0]       ex_exp_code,
output  reg [29:0]      mem_pc,
output  reg             mem_en,
output  reg             mem_br_flag,
output  reg [1:0]       mem_ctrl_op,
output  reg [4:0]       mem_dst_addr,
output  reg             mem_gpr_we_,
output  reg [2:0]       mem_exp_code,
output  reg [31:0]      mem_out 
  
    );
    /*Pipeline Register*/
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset   ==  `RESET_ENABLE) begin
            /*Asychronous Reset*/
            mem_pc          <=  #1  `WORD_ADDR_W'h0;
            mem_en          <=  #1  `DISABLE;
            mem_br_flag     <=  #1  `DISABLE;
            mem_ctrl_op     <=  #1  `CTRL_OP_NOP;
            mem_dst_addr    <=  #1  `REG_ADDR_W'h0;
            mem_gpr_we_     <=  #1  `DISABLE_;
            mem_exp_code    <=  #1  `ISA_EXP_NO_EXP;
            mem_out         <=  #1  `WORD_DATA_W'h0;
            
        end else begin
            if (stall   ==  `DISABLE)   begin
                /*Pipeline Register Updata*/
                if (flush   ==  `ENABLE) begin
                    mem_pc          <=  #1  `WORD_ADDR_W'h0;
                    mem_en          <=  #1  `DISABLE;
                    mem_br_flag     <=  #1  `DISABLE;
                    mem_ctrl_op     <=  #1  `CTRL_OP_NOP;
                    mem_dst_addr    <=  #1  `REG_ADDR_W'h0;
                    mem_gpr_we_     <=  #1  `DISABLE_;
                    mem_exp_code    <=  #1  `ISA_EXP_NO_EXP;
                    mem_out         <=  #1  `WORD_DATA_W'h0;
                end else if (miss_align ==  `ENABLE) begin
                    mem_pc          <=  #1  ex_pc;
                    mem_en          <=  #1  ex_en;
                    mem_br_flag     <=  #1  ex_br_flag;
                    mem_ctrl_op     <=  #1  `CTRL_OP_NOP;
                    mem_dst_addr    <=  #1  `REG_ADDR_W'h0;
                    mem_gpr_we_     <=  #1  `DISABLE_;
                    mem_exp_code    <=  #1  `ISA_EXP_MISS_ALIGN;
                    mem_out         <=  #1  `WORD_DATA_W'h0;
                end else begin
                    mem_pc          <=  #1  ex_pc;
                    mem_en          <=  #1  ex_en;
                    mem_br_flag     <=  #1  ex_br_flag;
                    mem_ctrl_op     <=  #1  ex_ctrl_op;
                    mem_dst_addr    <=  #1  ex_dst_addr;
                    mem_gpr_we_     <=  #1  ex_gpr_we_;
                    mem_exp_code    <=  #1  ex_exp_code;
                    mem_out         <=  #1  out;
                end
            end
        end
    end
    
endmodule












