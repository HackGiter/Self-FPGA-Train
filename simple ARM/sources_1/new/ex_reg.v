`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 16:15:23
// Design Name: 
// Module Name: ex_reg
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


module ex_reg(
/*Clock & Reset*/
input   wire        clk,
input   wire        reset,
/*Output of ALU*/
input   wire[31:0]  alu_out,
input   wire        alu_of,
/*Pipeline Control Signal*/
input   wire        stall,
input   wire        flush,
input   wire        int_detect,
/*ID/EX Pipeline Register*/
input   wire[29:0]  id_pc,
input   wire        id_en,
input   wire        id_br_flag,
input   wire[1:0]   id_mem_op,
input   wire[31:0]  id_mem_wr_data,
input   wire[1:0]   id_ctrl_op,
input   wire[4:0]   id_dst_addr,
input   wire        id_gpr_we_,
input   wire[2:0]   id_exp_code,
/*EX/MEM Pipeline Register*/
output  reg [29:0]  ex_pc,
output  reg         ex_en,
output  reg         ex_br_flag,
output  reg [1:0]   ex_mem_op,
output  reg [31:0]  ex_mem_wr_data,
output  reg [1:0]   ex_ctrl_op,
output  reg [4:0]   ex_dst_addr,
output  reg         ex_gpr_we_,
output  reg [2:0]   ex_exp_code,
output  reg [31:0]  ex_out
    );
    
    /*Pipelline Register*/
    always @(posedge clk or `RESET_EDGE reset) begin
        /*Asychronous Reset*/
        if (reset == `RESET_ENABLE) begin
            ex_pc           <=  #1 `WORD_ADDR_W'h0;
            ex_en           <=  #1 `DISABLE;
            ex_br_flag      <=  #1 `DISABLE;
            ex_mem_op       <=  #1 `MEM_OP_NOP;
            ex_mem_wr_data  <=  #1 `WORD_DATA_W'h0;
            ex_ctrl_op      <=  #1 `CTRL_OP_NOP;
            ex_dst_addr     <=  #1 `REG_ADDR_W'd0;
            ex_gpr_we_      <=  #1 `DISABLE_;
            ex_exp_code     <=  #1 `ISA_EXP_NO_EXP;
            ex_out          <=  #1 `WORD_DATA_W'h0;
        end else begin
            /*Update of Pipeline Register*/
            if (stall == `DISABLE) begin
                if (flush == `ENABLE) begin
                    ex_pc       <=  #1 `WORD_ADDR_W'h0;
                    ex_en       <=  #1 `DISABLE;
                    ex_br_flag  <=  #1 `DISABLE;
                    ex_mem_op   <=  #1 `MEM_OP_NOP;
                    ex_mem_wr_data <=   #1 `WORD_DATA_W'h0;
                    ex_ctrl_op  <=  #1 `CTRL_OP_NOP;
                    ex_dst_addr <=  #1 `REG_ADDR_W'd0;
                    ex_gpr_we_  <=  #1 `DISABLE_;
                    ex_exp_code <=  #1 `ISA_EXP_NO_EXP;
                    ex_out      <=  #1 `WORD_DATA_W'h0;
                end else if (int_detect == `ENABLE) begin
                    ex_pc       <=  #1 id_pc;
                    ex_en       <=  #1 id_en;
                    ex_br_flag  <=  #1 id_br_flag;
                    ex_mem_op   <=  #1 `MEM_OP_NOP;
                    ex_mem_wr_data  <= #1 `WORD_DATA_W'h0;
                    ex_ctrl_op  <=  #1 `CTRL_OP_NOP;
                    ex_dst_addr <=  #1 `REG_ADDR_W'd0;
                    ex_gpr_we_  <=  #1 `DISABLE_;
                    ex_exp_code <=  #1 `ISA_EXP_EXT_INT;
                    ex_out      <=  #1 `WORD_DATA_W'h0;
                end else if (alu_of == `ENABLE) begin
                    ex_pc       <=  #1 id_pc;
                    ex_en       <=  #1 id_en;
                    ex_br_flag  <=  #1 id_br_flag;
                    ex_mem_op   <=  #1 `MEM_OP_NOP;
                    ex_mem_wr_data  <=  #1 `WORD_DATA_W'h0;
                    ex_ctrl_op  <=  #1 `CTRL_OP_NOP;
                    ex_dst_addr <=  #1 `REG_ADDR_W'd0;
                    ex_gpr_we_  <=  #1 `DISABLE_;
                    ex_exp_code <=  #1 `ISA_EXP_OVERFLOW;
                    ex_out      <=  #1 `WORD_DATA_W'h0;
                end else begin
                    ex_pc       <=  #1 id_pc;
                    ex_en       <=  #1 id_en;
                    ex_br_flag  <=  #1 id_br_flag;
                    ex_mem_op   <=  #1 id_mem_op;
                    ex_mem_wr_data  <=  #1 id_mem_wr_data;
                    ex_ctrl_op  <=  #1 id_ctrl_op;
                    ex_dst_addr <=  #1 id_dst_addr;
                    ex_gpr_we_  <=  #1 id_gpr_we_;
                    ex_exp_code <=  #1 id_exp_code;
                    ex_out      <=  #1 alu_out;
                end
            end
        end
    end
endmodule
