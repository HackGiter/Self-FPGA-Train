`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 14:06:45
// Design Name: 
// Module Name: id_reg
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


module id_reg(
/*Clock & Reset*/
input   wire        clk,
input   wire        reset,
/*Decode Result*/
input   wire[3:0]   alu_op,
input   wire[31:0]  alu_in_0,
input   wire[31:0]  alu_in_1,
input   wire        br_flag,
input   wire[1:0]   mem_op,
input   wire[31:0]  mem_wr_data,
input   wire[1:0]   ctrl_op,
input   wire[4:0]   dst_addr,
input   wire        gpr_we_,
input   wire[2:0]   exp_code,
/*Pipeline Control Signal*/
input   wire        stall,
input   wire        flush,
/*IF/ID Pipeline Register*/
input   wire[29:0]  if_pc,
input   wire        if_en,
/*ID/EX Pipeline Register*/
output  reg [29:0]  id_pc,
output  reg         id_en,
output  reg [3:0]   id_alu_op,
output  reg [31:0]  id_alu_in_0,
output  reg [31:0]  id_alu_in_1,
output  reg         id_br_flag,
output  reg [1:0]   id_mem_op,
output  reg [31:0]  id_mem_wr_data,
output  reg [1:0]   id_ctrl_op,
output  reg [4:0]   id_dst_addr,
output  reg         id_gpr_we_,
output  reg [2:0]   id_exp_code
    );
    
    /*Pipeline Register*/
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            /*Asychronous Reset*/
            id_pc           <=  #1  `WORD_ADDR_W'h0;
            id_en           <=  #1  `DISABLE;
            id_alu_op       <=  #1  `ALU_OP_NOP;
            id_alu_in_0     <=  #1  `WORD_DATA_W'h0;
            id_alu_in_1     <=  #1  `WORD_DATA_W'h0;
            id_br_flag      <=  #1  `DISABLE;
            id_mem_op       <=  #1  `MEM_OP_NOP;
            id_mem_wr_data  <=  #1  `WORD_DATA_W'h0;
            id_ctrl_op      <=  #1  `CTRL_OP_NOP;
            id_dst_addr     <=  #1  `REG_ADDR_W'd0;
            id_gpr_we_      <=  #1  `DISABLE_;
            id_exp_code     <=  #1  `ISA_EXP_NO_EXP;
        end else begin
            /*update of pu=ipeline register*/
            if (stall   ==  `DISABLE) begin
                if (flush   ==  `ENABLE) begin
                    id_pc           <=  #1  `WORD_ADDR_W'h0;
                    id_en           <=  #1  `DISABLE;
                    id_alu_op       <=  #1  `ALU_OP_NOP;
                    id_alu_in_0     <=  #1  `WORD_DATA_W'h0;
                    id_alu_in_1     <=  #1  `WORD_DATA_W'h0;
                    id_br_flag      <=  #1  `DISABLE;
                    id_mem_op       <=  #1  `MEM_OP_NOP;
                    id_mem_wr_data  <=  #1  `WORD_DATA_W'h0;
                    id_ctrl_op      <=  #1  `CTRL_OP_NOP;
                    id_dst_addr     <=  #1  `REG_ADDR_W'd0;
                    id_gpr_we_      <=  #1  `DISABLE_;
                    id_exp_code     <=  #1  `ISA_EXP_NO_EXP;
                end else begin
                    id_pc           <=  #1  if_pc;
                    id_en           <=  #1  if_en;
                    id_alu_op       <=  #1  alu_op;
                    id_alu_in_0     <=  #1  alu_in_0;
                    id_alu_in_1     <=  #1  alu_in_1;
                    id_br_flag      <=  #1  br_flag;
                    id_mem_op       <=  #1  mem_op;
                    id_mem_wr_data  <=  #1  mem_wr_data;
                    id_ctrl_op      <=  #1  ctrl_op;
                    id_dst_addr     <=  #1  dst_addr;
                    id_gpr_we_      <=  #1  gpr_we_;
                    id_exp_code     <=  #1  exp_code;
                end
            end
        end
    end
    
endmodule
