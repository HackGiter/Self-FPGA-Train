`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/05 12:21:13
// Design Name: 
// Module Name: id_stage
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


module id_stage(
/*IF/ID Pipeline Register*/
input   wire[29:0]  if_pc,
input   wire[31:0]  if_insn,
input   wire        if_en,
/*General Register Access*/
input   wire[31:0]  gpr_rd_data_0,
input   wire[31:0]  gpr_rd_data_1,
output  wire[4:0]   gpr_rd_addr_0,
output  wire[4:0]   gpr_rd_addr_1,
/*pipeline Control Signal*/
output  wire[29:0]  br_addr,
output  wire        br_taken,
output  wire        ld_hazard,
/*straight through*/
input   wire        ex_en,
input   wire[4:0]   ex_dst_addr,
input   wire        ex_gpr_we_,
input   wire[31:0]  ex_fwd_data,
/*the data straight throught from MEM stage*/
input   wire[31:0]  mem_fwd_data,
/*the Control Register Interface*/
input   wire        exe_mode,
input   wire[31:0]  creg_rd_data,
output  wire[4:0]   creg_rd_addr,
/*Clock & Reset*/
input   wire        clk,
input   wire        reset,
/*Pipeline Control Signal*/
input   wire        stall,
input   wire        flush,
/*ID/EX Pipeline Register*/
output  wire[29:0]  id_pc,
output  wire        id_en,
output  wire[3:0]   id_alu_op,
output  wire[31:0]  id_alu_in_0,
output  wire[31:0]  id_alu_in_1,
output  wire        id_br_flag,
output  wire[1:0]   id_mem_op,
output  wire[31:0]  id_mem_wr_data,
output  wire[1:0]   id_ctrl_op,
output  wire[4:0]   id_dst_addr,
output  wire        id_gpr_we_,
output  wire[2:0]   id_exp_code
    );
    wire[3:0]   alu_op;
    wire[31:0]  alu_in_0;
    wire[31:0]  alu_in_1;
    wire        br_flag;
    wire[1:0]   mem_op;
    wire[31:0]  mem_wr_data;
    wire[1:0]   ctrl_op;
    wire[4:0]   dst_addr;
    wire        gpr_we_;
    wire[2:0]   exp_code;
    
    decoder decoder(
        /*IF/ID Pipeline Register*/
        .if_pc(if_pc),
        .if_insn(if_insn),
        .if_en(if_en),
        /*GPR Interfare*/
        .gpr_rd_data_0(gpr_rd_data_0),
        .gpr_rd_data_1(gpr_rd_data_1),
        .gpr_rd_addr_0(gpr_rd_addr_0),
        .gpr_rd_addr_1(gpr_rd_addr_1),
        /*the data straight through from ID stage*/
        .id_en(id_en),
        .id_dst_addr(id_dst_addr),
        .id_gpr_we_(id_gpr_we_),
        .id_mem_op(id_mem_op),
        /*the data straight through from EX stage*/
        .ex_en(ex_en),
        .ex_dst_addr(ex_dst_addr),
        .ex_gpr_we_(ex_gpr_we_),
        .ex_fwd_data(ex_fwd_data),
        /*the data straight throught from MEM stage*/
        .mem_fwd_data(mem_fwd_data),
        /*the Control Register Interface*/
        .exe_mode(exe_mode),
        .creg_rd_data(creg_rd_data),
        .creg_rd_addr(creg_rd_addr),
        /*decode result*/
        .alu_op(alu_op),
        .alu_in_0(alu_in_0),
        .alu_in_1(alu_in_1),
        .br_addr(br_addr),
        .br_taken(br_taken),
        .br_flag(br_flag),
        .mem_op(mem_op),
        .mem_wr_data(mem_wr_data),
        .ctrl_op(ctrl_op),
        .dst_addr(dst_addr),
        .gpr_we_(gpr_we_),
        .exp_code(exp_code),
        .ld_hazard(ld_hazard)
    );
    
    id_reg id_reg(
            /*Clock & Reset*/
            .clk(clk),
            .reset(reset),
            /*Decode Result*/
            .alu_op(alu_op),
            .alu_in_0(alu_in_0),
            .alu_in_1(alu_in_1),
            .br_flag(br_flag),
            .mem_op(mem_op),
            .mem_wr_data(mem_wr_data),
            .ctrl_op(ctrl_op),
            .dst_addr(dst_addr),
            .gpr_we_(gpr_we_),
            .exp_code(exp_code),
            /*Pipeline Control Signal*/
            .stall(stall),
            .flush(flush),
            /*IF/ID Pipeline Register*/
            .if_pc(if_pc),
            .if_en(if_en),
            /*ID/EX Pipeline Register*/
            .id_pc(id_pc),
            .id_en(id_en),
            .id_alu_op(id_alu_op),
            .id_alu_in_0(id_alu_in_0),
            .id_alu_in_1(id_alu_in_1),
            .id_br_flag(id_br_flag),
            .id_mem_op(id_mem_op),
            .id_mem_wr_data(id_mem_wr_data),
            .id_ctrl_op(id_ctrl_op),
            .id_dst_addr(id_dst_addr),
            .id_gpr_we_(id_gpr_we_),
            .id_exp_code(id_exp_code)
    );

endmodule
