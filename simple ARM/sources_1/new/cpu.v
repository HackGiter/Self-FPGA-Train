`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 15:46:30
// Design Name: 
// Module Name: cpu
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


module cpu(
/*Clock & Reset*/
input       wire        clk,
input       wire        reset,
/*IF phase Bus Interface*/
input       wire[31:0]  if_bus_rd_data,
input       wire        if_bus_rdy_,
input       wire        if_bus_grnt_,
input       wire        if_bus_req_,
input       wire[29:0]  if_bus_addr,
input       wire        if_bus_as_,
input       wire        if_bus_rw,
input       wire[31:0]  if_bus_wr_data,

/*Interruption Request*/
input       wire[7:0]   cpu_irq,

/*MEM stage Bus Interface*/
input       wire[31:0]  mem_bus_rd_data,
input       wire        mem_bus_rdy_,
input       wire        mem_bus_grnt_,
output      wire        mem_bus_req_,
output      wire[29:0]  mem_bus_addr,
output      wire        mem_bus_as_,
output      wire        mem_bus_rw,      
output      wire[31:0]  mem_bus_wr_data

    );
    
    wire        busy;
    wire        stall;
    wire        flush;
    wire[29:0]  new_pc;
    
    wire        br_taken;
    wire[29:0]  br_addr;
    wire[29:0]  if_pc;
    wire[31:0]  if_insn;
    wire        if_en;
    
//    wire[31:0]  spm_rd_data;
//    wire        spm_addr;
//    wire        spm_as_;
//    wire        spm_rw;
//    wire[31:0]  spm_wr_data;
    
    wire[4:0]   creg_rd_addr;
    wire        ld_hazard;
    wire        exe_mode;
    wire[31:0]  creg_rd_data;
    wire        stall;
    wire        flush;
    wire[31:0]  mem_fwd_data;
    wire        ex_gpr_we_;
    wire[31:0]  ex_fwd_data;
    wire[29:0]  id_pc;
    wire        id_en;
    wire        id_alu_op;
    wire[31:0]  id_alu_in_0;
    wire[31:0]  id_alu_in_1;
    wire        id_br_flag;
    wire[1:0]   id_mem_op;
    wire[31:0]  id_mem_wr_data;
    wire[1:0]   id_ctrl_op;
    wire[4:0]   id_dst_ctrl;
    wire        id_gpr_we_;
    wire[2:0]   id_exp_code;
    
    wire[31:0]  gpr_rd_data_1;
    wire[31:0]  gpr_rd_data_0;
    wire[31:0]      rd_data_0;
    wire[31:0]      rd_data_1;
    
    wire[31:0]  mem_spm_rd_data;
    wire[11:0]  spm_addr;
    wire        spm_as_;
    wire        spm_rw;
    wire[31:0]  spm_wr_data;
    
    wire[31:0]  fwd_data;
    
    
    
    if_stage if_stage(
        /*clock & reset*/
        .clk(clk),        
        .reset(reset),   
         /*pipeline control signal*/
        .stall(stall),
        .flush(flush),
        .new_pc(new_pc),
        .br_taken(br_taken),
        .br_addr(br_addr),
        /*IF/ID Pipeline Register*/
        .if_pc(if_pc),
        .if_insn(if_insn),
        .if_en(if_en),  
        /*Bus Busy Signal*/        
        .busy(busy),           
        /*SPM Interface*/
        .bus_rd_data(if_bus_rd_data),
        .spm_addr(spm_addr),
        .spm_as_(spm_as_),
        .spm_rw(spm_rw),
        .spm_rd_data(spm_rd_data),
        .spm_wr_data(spm_wr_data),
        //output  wire[31:0]  bus_rd_data,
        /*Bus Interface*/
        .bus_rdy_(if_bus_rdy_),
        .bus_grnt_(if_bus_grnt_),
        .bus_req_(if_bus_req_),
        .bus_addr(if_bus_addr),
        .bus_as_(if_bus_as_),
        .bus_rw(if_bus_rw),
        .bus_wr_data(if_bus_wr_data)
    );
    
    id_stage id_stage(
        /*IF/ID Pipeline Register*/
        .if_pc(if_pc),
        .if_insn(if_insn),
        .if_en(if_en),
        /*General Register Access*/
        .gpr_rd_data_0(gpr_rd_data_0),
        .gpr_rd_data_1(gpr_rd_data_1),
        .gpr_rd_addr_0(rd_data_0),
        .gpr_rd_addr_1(rd_data_1),
        /*pipeline Control Signal*/
        .br_addr(br_addr),
        .br_taken(br_taken),
        .ld_hazard(ld_hazard),
        /*straight through*/
        .ex_en(ex_en),
        .ex_dst_addr(ex_dst_addr),
        .ex_gpr_we_(ex_gpr_we_),
        .ex_fwd_data(fwd_data),
        /*the data straight throught from MEM stage*/
        .mem_fwd_data(mem_fwd_data),
        /*the Control Register Interface*/
        .exe_mode(exe_mode),
        .creg_rd_data(creg_rd_data),
        .creg_rd_addr(creg_rd_addr),
        /*Clock & Reset*/
        .clk(clk),
        .reset(reset),
        /*Pipeline Control Signal*/
        .stall(stall),
        .flush(flush),
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
    
    spm spm(
        .clk(clk),            //clock
        /*A port IF stage*/
        .if_spm_addr(spm_addr),    //address
        .if_spm_as_(spm_as_),     //address select
        .if_spm_rw(spm_rw),     //read/write
        .if_spm_wr_data(spm_wr_data), //the data write in
        .if_spm_rd_data(spm_rd_data), //the data read
        /*B port MEM stage*/
        .mem_spm_addr(spm_addr),   //address
        .mem_spm_as_(spm_as_),    //address select
        .mem_spm_rw(spm_rw),     //read/write
        .mem_spm_wr_data(spm_wr_data),    //the data write in
        .mem_spm_rd_data(mem_spm_rd_data)     //the data read
    );
    
    ex_stage ex_stage(
        /*Input*/
        .id_alu_in_0(id_alu_in_0),
        .id_alu_in_1(id_alu_in_1),
        .id_alu_op(id_alu_op),
        /*Operation Result*/
        .fwd_data(ex_fwd_data),
        /*Clock & Reset*/
        .clk(clk),
        .reset(reset),
        /*Output of ALU*/
        /*Pipeline Control Signal*/
        .stall(ex_stall),
        .flush(ex_flush),
        .int_detect(int_detect),
        /*ID/EX Pipeline Register*/
        .id_pc(id_pc),
        .id_en(id_en),
        .id_br_flag(id_br_flag),
        .id_mem_op(id_mem_op),
        .id_mem_wr_data(id_mem_wr_data),
        .id_ctrl_op(id_ctrl_op),
        .id_dst_addr(id_dst_addr),
        .id_gpr_we_(id_gpr_we_),
        .id_exp_code(id_exp_code),
        /*EX/MEM Pipeline Register*/
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
    

    
    gpr gpr(
        .clk(clk),
        .reset(reset),
        .rd_addr_0(gpr_rd_data_1),
        .rd_data_0(rd_data_0),
        .rd_addr_1(gpr_rd_data_0),
        .rd_data_1(rd_data_1),
        .we_(mem_gpr_we_),
        .wr_addr(mem_dst_addr),
        .wr_data(mem_out)
    );
    
    mem_stage mem_stage(
        /*clock & reset*/
        .clk(clk),        
        .reset(reset),   
         /*pipeline control signal*/
        .stall(mem_stall),
        .flush(mem_flush),          
        .busy(busy),
        .fwd_data(fwd_data),           
        /*cpu interface*/
        /*spm interface*/
        .spm_rd_data(mem_spm_rd_data),
        .spm_addr(spm_addr),
        .spm_as_(spm_as_),
        .spm_rw(spm_rw),
        .spm_wr_data(spm_wr_data),
        /*bus interface*/
        .bus_rd_data(mem_bus_rd_data),
        .bus_rdy_(mem_bus_rdy_),
        .bus_grnt_(mem_bus_grnt_),
        .bus_req_(mem_bus_req_),
        //output  wire[29:0]  bus_addr,
        .bus_addr(mem_bus_addr),
        .bus_as_(mem_bus_as_),
        //output  wire        bus_rw,
        //output  wire[31:0]  bus_wr_data  
        .bus_rw(mem_bus_rw),
        .bus_wr_data(mem_bus_wr_data), 
        
        /*EX/MEM Pipeline Register*/
        .ex_en(ex_en),
        .ex_mem_op(ex_mem_op),
        .ex_mem_wr_data(ex_mem_wr_data),
        .ex_out(ex_out),
        
        /*result of memory access*/
        /*Clock & Reset*/
        /*Memory Access Result*/
        /*Pipeline Control Signal*/
        /*EX/MEM Pipeline Register*/
        .ex_pc(ex_pc),
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
    
    ctrl ctrl(
        /*Clock & Reset*/
        .clk(clk),
        .reset(reset),
        /*Control Register Interface*/
        .creg_rd_addr(creg_rd_addr),
        .creg_rd_data(creg_rd_data),
        .exe_mode(exe_mode),
        /*interuption*/
        .irq(cpu_irq),
        .int_detect(int_detect),
        /*ID/EX Pipeline Register*/
        .id_pc(id_pc),
        /*MEM/WB Pipeline Register*/
        .mem_pc(mem_pc),
        .mem_en(mem_en),
        .mem_br_flag(mem_br_flag),
        .mem_ctrl_op(mem_ctrl_op),
        .mem_dst_addr(mem_dst_addr),
        .mem_gpr_we_(mem_gpr_we_),
        .mem_exp_code(mem_exp_code),
        .mem_out(mem_out),
        /*Status of Pipeline*/
        .if_busy(if_busy),
        .ld_hazard(ld_hazard),
        .mem_busy(busy),
        /*Delay signal*/
        .if_stall(if_stall),
        .id_stall(id_stall),
        .ex_stall(ex_stall),
        .mem_stall(mem_stall),
        /*Refresh*/
        .if_flush(if_flush),
        .id_flush(id_flush),
        .ex_flush(ex_flush),
        .mem_flush(mem_flush),
        .new_pc(new_pc)
    
    );
    
endmodule
