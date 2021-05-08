`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/05 23:22:37
// Design Name: 
// Module Name: mem_stage
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


module mem_stage(
output  wire[31:0]  fwd_data,
/*clock & reset*/
input   wire        clk,        
input   wire        reset,   
 /*pipeline control signal*/
input   wire        stall,
input   wire        flush,  
/*Busy Signal*/        
output  wire        busy,           
/*cpu interface*/
/*spm interface*/
input   wire[31:0]  spm_rd_data,
output  wire[29:0]  spm_addr,
output  wire        spm_as_,
output  wire        spm_rw,
output  wire[31:0]  spm_wr_data,
/*bus interface*/
input   wire[31:0]  bus_rd_data,
input   wire        bus_rdy_,
input   wire        bus_grnt_,
output  wire        bus_req_,
//output  wire[29:0]  bus_addr,
output  wire[29:0]  bus_addr,
output  wire        bus_as_,
//output  wire        bus_rw,
//output  wire[31:0]  bus_wr_data  
output  wire        bus_rw,
output  wire[31:0]  bus_wr_data, 

/*EX/MEM Pipeline Register*/
input   wire        ex_en,
input   wire[1:0]   ex_mem_op,
input   wire[31:0]  ex_mem_wr_data,
input   wire[31:0]  ex_out,

/*result of memory access*/
/*Clock & Reset*/
/*Memory Access Result*/
/*Pipeline Control Signal*/
/*EX/MEM Pipeline Register*/
input   wire[29:0]      ex_pc,
input   wire            ex_br_flag,
input   wire[1:0]       ex_ctrl_op,
input   wire[4:0]       ex_dst_addr,
input   wire            ex_gpr_we_,
input   wire[2:0]       ex_exp_code,
output  wire[29:0]      mem_pc,
output  wire            mem_en,
output  wire            mem_br_flag,
output  wire[1:0]       mem_ctrl_op,
output  wire[4:0]       mem_dst_addr,
output  wire            mem_gpr_we_,
output  wire[2:0]       mem_exp_code,
output  wire[31:0]      mem_out 
    );
    /*Memory Access Interface*/
    wire[31:0]  rd_data;
    wire[29:0]  addr;
    wire        as_;
    wire        rw;
    wire[31:0]  wr_data;
    bus_if bus_if(
        /*busy signal*/
        .busy(busy),   
        /*clock & reset*/
        .clk(clk),        
        .reset(reset),   
         /*pipeline control signal*/
        .stall(stall),
        .flush(flush),
        .addr(addr),           
        .as_(as_),            
        .rw(rw),
        .wr_data(wr_data),
        .rd_data(rd_data),
        /*spm interface*/
        .spm_rd_data(spm_rd_data),
        .spm_addr(spm_addr),
        .spm_as_(spm_as_),
        .spm_rw(spm_rw),
        .spm_wr_data(spm_wr_data),
        /*bus interface*/
        .bus_rd_data(bus_rd_data),
        .bus_rdy_(bus_rdy_),
        .bus_grnt_(bus_grnt_),
        .bus_req_(bus_req_),
        .bus_addr(bus_addr),
        .bus_as_(bus_as_),
        .bus_rw(bus_rw),
        .bus_wr_data(bus_wr_data)
    );
    
    mem_ctrl mem_ctrl(
        /*EX/MEM Pipeline Register*/
        .ex_en(ex_en),
        .ex_mem_op(ex_mem_op),
        .ex_mem_wr_data(ex_mem_wr_data),
        .ex_out(ex_out),
        /*Memory Access Interface*/
        .rd_data(rd_data),
        .addr(addr),
        .as_(as_),
        .rw(rw),
        .wr_data(wr_data),
        /*result of memory access*/
        .out(fwd_data),
        .miss_align(miss_align)
    );
    
    mem_reg mem_reg(
        /*Clock & Reset*/
        .clk(clk),
        .reset(reset),
        /*Memory Access Result*/
        .out(fwd_data),
        .miss_align(miss_align),
        /*Pipeline Control Signal*/
        .stall(stall),
        .flush(flush),
        /*EX/MEM Pipeline Register*/
        .ex_pc(ex_pc),
        .ex_en(ex_en),
        .ex_br_flag(ex_br_flag),
        .ex_ctrl_op(ex_ctrl_op),
        .ex_dst_addr(ex_dst_addr),
        .ex_gpr_we_(ex_gpr_we_),
        .ex_exp_code(ex_exp_code),
        .mem_pc(mem_pc),
        .mem_en(mem_en),
        .mem_br_flag(mem_br_flag),
        .mem_ctrl_op(mem_ctrl_op),
        .mem_dst_addr(mem_dst_addr),
        .mem_gpr_we_(mem_gpr_we_),
        .mem_exp_code(mem_exp_code),
        .mem_out(mem_out)
    );
    
    
    
endmodule











