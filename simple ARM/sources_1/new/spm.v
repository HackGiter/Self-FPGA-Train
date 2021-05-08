`timescale 1ns / 1ps
`include "spm.vh"
`include "cpu.vh"
`include "isa.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/03 22:21:57
// Design Name: 
// Module Name: spm
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

/*scratch pad memory*/
module spm(
input   wire            clk,            //clock
/*A port IF stage*/
input   wire[11:0]      if_spm_addr,    //address
input   wire            if_spm_as_,     //address select
input   wire            if_spm_rw,     //read/write
input   wire[31:0]      if_spm_wr_data, //the data write in
output  wire[31:0]      if_spm_rd_data, //the data read
/*B port MEM stage*/
input   wire[11:0]      mem_spm_addr,   //address
input   wire            mem_spm_as_,    //address select
input   wire            mem_spm_rw,     //read/write
input   wire[31:0]      mem_spm_wr_data,    //the data write in
output  wire[31:0]      mem_spm_rd_data     //the data read
    );
    /*A port*/
    reg     wea;        //write enable
    /*B port*/
    reg     web;        //write enable
    
    /*the generation of write enable signal*/
    always @(*) begin
        /*A port*/
        if ((if_spm_as_ == `ENABLE_) && (if_spm_rw == `WRITE)) begin
            wea = `MEM_ENABLE;
        end else begin 
            wea = `MEM_DISABLE;
        end
        /*B port*/
        if ((mem_spm_as_ == `ENABLE_) && (mem_spm_rw == `WRITE)) begin
            web = `MEM_ENABLE;
        end else begin
            web = `MEM_DISABLE;
        end
    end
    
    
    /*Xilinx FPGA Block RAM dual port*/
    x_s3e_dpram x_s3e_dpram (
        /*A port : IF stage*/
        .clka(clk),
        .addra(if_spm_addr),
        .dina(if_spm_wr_data),
        .wea(wea),
        .douta(if_spm_rd_data),
        /*B port: MEM stage*/
        .clkb(clk),
        .addrb(mem_spm_addr),
        .dinb(mem_spm_wr_data),
        .web(web),
        .doutb(mem_sprm_rd_data)
    );
    
    
endmodule
