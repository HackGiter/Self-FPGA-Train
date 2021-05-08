`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 20:35:07
// Design Name: 
// Module Name: bus_master_mux
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


module bus_master_mux(
/*number 0 bus master*/
input   wire[29:0]  m0_addr,        //address
input   wire        m0_as_,         //address select
input   wire        m0_rw,          //read/write
input   wire[31:0]  m0_wr_data,     //the data write in
input   wire        m0_grnt_,       //assign bus
/*number 1 bus master*/
input   wire[29:0]  m1_addr,        //address
input   wire        m1_as_,         //address select
input   wire        m1_rw,          //read/write
input   wire[31:0]  m1_wr_data,     //the data write in
input   wire        m1_grnt_,       //assign bus
/*number 2 bus master*/
input   wire[29:0]  m2_addr,        //address
input   wire        m2_as_,         //address select
input   wire        m2_rw,          //read/write
input   wire[31:0]  m2_wr_data,     //the data write in
input   wire        m2_grnt_,       //assign bus
/*number 3 bus master*/
input   wire[29:0]  m3_addr,        //address
input   wire        m3_as_,         //address select
input   wire        m3_rw,          //read/write
input   wire[31:0]  m3_wr_data,     //the data write in
input   wire        m3_grnt_,       //assign bus
/*share signal bus slave*/
output  reg [29:0]  s_addr,         //address
output  reg         s_as_,          //address select
output  reg         s_rw,           //read/write
output  reg [31:0]  s_wr_data       //the data write in

    );
    /*bus master multiplexer*/
    always  @(*)    begin
        /*the bus master chosed the usage of bus*/
        if (m0_grnt_ == `ENABLE_)   begin
            s_addr      = m0_addr;
            s_as_       = m0_as_;
            s_rw        = m0_rw;
            s_wr_data   = m0_wr_data;
        end else if (m1_grnt_ == `ENABLE_)   begin
            s_addr      = m1_addr;
            s_as_       = m1_as_;
            s_rw        = m1_rw;
            s_wr_data   = m1_wr_data;
        end else if (m2_grnt_ == `ENABLE_)   begin
            s_addr      = m2_addr;
            s_as_       = m2_as_;
            s_rw        = m2_rw;
            s_wr_data   = m2_wr_data;
        end else if (m3_grnt_ == `ENABLE_)   begin
            s_addr      = m3_addr;
            s_as_       = m3_as_;
            s_rw        = m3_rw;
            s_wr_data   = m3_wr_data;
        end else begin
            s_addr      = `WORD_ADDR_W'h0;
            s_as_       = `DISABLE_;
            s_rw        = `READ;
            s_wr_data   = `WORD_DATA_W'h0;
        end
    end
    
    
endmodule
