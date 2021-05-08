`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 11:04:21
// Design Name: 
// Module Name: if_stage
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


module if_stage(
/*clock & reset*/
input   wire        clk,        
input   wire        reset,   
 /*pipeline control signal*/
input   wire        stall,
input   wire        flush,
input   wire[29:0]  new_pc,
input   wire        br_taken,
input   wire[29:0]  br_addr,
/*IF/ID Pipeline Register*/
output  wire[29:0]  if_pc,
output  wire[31:0]  if_insn,
output  wire        if_en,  
/*Bus Busy Signal*/        
output  wire        busy,           
/*SPM Interface*/
input   wire[31:0]  bus_rd_data,
output  wire[29:0]  spm_addr,
output  wire        spm_as_,
output  wire        spm_rw,
output  wire[31:0]  spm_rd_data,
output  wire[31:0]  spm_wr_data,
//output  wire[31:0]  bus_rd_data,
/*Bus Interface*/
input   wire        bus_rdy_,
input   wire        bus_grnt_,
output  wire        bus_req_,
output  wire[29:0]  bus_addr,
output  wire        bus_as_,
output  wire        bus_rw,
output  wire[31:0]  bus_wr_data
    );
    wire[31:0]  rd_data;
    
        
    bus_if busif(
        /*clock & reset*/
        .clk(clk),        
        .reset(reset),   
        /*pipeline control signal*/
        .stall(stall),
        .flush(flush),          
        .busy(busy),           
        /*cpu interface*/
        .addr(addr),           
        .as_(as_),            
        .rw(rw),
        .wr_data(we_data),
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
        //output  wire[29:0]  bus_addr,
        .bus_addr(bus_addr),
        .bus_as_(bus_as_),
        //output  wire        bus_rw,
        //output  wire[31:0]  bus_wr_data  
        .bus_rw(bus_rw),
        .bus_wr_data(bus_wr_data)  
    );
    
    if_reg ifreg(
        .new_pc(new_pc),
        .br_taken(br_taken),
        .br_addr(br_addr),
        .if_pc(if_pc),
        .if_insn(if_insn),
        .if_en(if_en),
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(flush),
        .insn(rd_data)
    );

endmodule
