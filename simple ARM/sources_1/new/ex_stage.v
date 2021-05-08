`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/05 22:49:40
// Design Name: 
// Module Name: ex_stage
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


module ex_stage(
/*Input*/
input   wire[31:0]      id_alu_in_0,
input   wire[31:0]      id_alu_in_1,
input   wire[3:0]       id_alu_op,
/*Operation Result*/
output  wire[31:0]      fwd_data,
/*Clock & Reset*/
input   wire        clk,
input   wire        reset,
/*Output of ALU*/

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
output  wire[29:0]  ex_pc,
output  wire        ex_en,
output  wire        ex_br_flag,
output  wire[1:0]   ex_mem_op,
output  wire[31:0]  ex_mem_wr_data,
output  wire[1:0]   ex_ctrl_op,
output  wire[4:0]   ex_dst_addr,
output  wire        ex_gpr_we_,
output  wire[2:0]   ex_exp_code,
output  wire[31:0]  ex_out
    );
    
    wire        of;
    alu alu(
        .op(id_alu_op),
        .in_0(id_alu_in_0),
        .in_1(id_alu_in_1),
        .out(fwd_data),
        .of(of)
    );
    
    ex_reg ex_reg(
        .clk(clk),
        .reset(reset),
        .alu_out(out),
        .alu_of(of),
        .stall(stall),
        .flush(flush),
        .int_detect(int_detect),
        .id_pc(id_pc),
        .id_en(id_en),
        .id_br_flag(id_br_flag),
        .id_mem_op(id_mem_op),
        .id_mem_wr_data(id_mem_wr_data),
        .id_ctrl_op(id_ctrl_op),
        .id_dst_addr(id_dst_addr),
        .id_gpr_we_(id_gpr_we_),
        .id_exp_code(id_exp_code),
        .ex_pc(ex_pc),
        .ex_en(ex_en),
        .ex_br_flag(ex_br_flag),
        .ex_mem_op(ex_mem_op),
        .ex_mem_wr_data(ex_mem_wr_data),
        .ex_ctrl_op(ex_ctrl_op),
        .ex_dst_addr(ex_dst_addr),
        .ex_gpr_we_(ex_gpr_we_),
        .ex_exp_code(ex_exp_code),
        .ex_out(ex_out)
    );  
    
endmodule
