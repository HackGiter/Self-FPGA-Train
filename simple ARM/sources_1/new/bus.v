`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 22:43:07
// Design Name: 
// Module Name: bus
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


module bus(
input   wire    clk,        //clock
/*number zero bus master*/
input   wire    reset,      //asynchronous  reset
input   wire    m0_req_,     //request bus
/*number one bus master*/
input   wire    m1_req_,
/*number two bus master*/
input   wire    m2_req_,
/*number three bus master*/
input   wire    m3_req_,
input   wire[29:0]  m0_addr,        //address
input   wire        m0_as_,         //address select
input   wire        m0_rw,          //read/write
input   wire[31:0]  m0_wr_data,     //the data write in
/*number 1 bus master*/
input   wire[29:0]  m1_addr,        //address
input   wire        m1_as_,         //address select
input   wire        m1_rw,          //read/write
input   wire[31:0]  m1_wr_data,     //the data write in
/*number 2 bus master*/
input   wire[29:0]  m2_addr,        //address
input   wire        m2_as_,         //address select
input   wire        m2_rw,          //read/write
input   wire[31:0]  m2_wr_data,     //the data write in
/*number 3 bus master*/
input   wire[29:0]  m3_addr,        //address
input   wire        m3_as_,         //address select
input   wire        m3_rw,          //read/write
input   wire[31:0]  m3_wr_data,     //the data write in
input   wire[31:0]  s0_rd_data, //the data read  
input   wire        s0_rdy_,     //ready
input   wire[31:0]  s1_rd_data, //the data read  
input   wire        s1_rdy_,     //ready
input   wire[31:0]  s2_rd_data, //the data read  
input   wire        s2_rdy_,     //ready
input   wire[31:0]  s3_rd_data, //the data read  
input   wire        s3_rdy_,     //ready
input   wire[31:0]  s4_rd_data, //the data read  
input   wire        s4_rdy_,     //ready
input   wire[31:0]  s5_rd_data, //the data read  
input   wire        s5_rdy_,     //ready
input   wire[31:0]  s6_rd_data, //the data read  
input   wire        s6_rdy_,     //ready
input   wire[31:0]  s7_rd_data, //the data read  
input   wire        s7_rdy_,     //ready,

output  wire [29:0]  s_addr,         //address
output  wire        s_as_,          //address select
output  wire        s_rw,           //read/write
output  wire[31:0]  s_wr_data,       //the data write in
output  wire            s0_cs_,     //chip select
output  wire            s1_cs_,     //chip select
output  wire            s2_cs_,     //chip select
output  wire            s3_cs_,     //chip select
output  wire            s4_cs_,     //chip select
output  wire            s5_cs_,     //chip select
output  wire            s6_cs_,     //chip select
output  wire            s7_cs_,      //chip select
output  wire[31:0]  m_rd_data,  //the data read
output  wire        m_rdy_       //ready
    );
    
    bus_arbiter bus_aribiter (
        .clk(clk),
        .reset(reset),
        .m0_req_(m0_req_),
        .m1_req_(m1_req_),
        .m2_req_(m2_req_),
        .m3_req_(m3_req_),
        .m0_grnt_(m0_grnt_),
        .m1_grnt_(m1_grnt_),
        .m2_grnt_(m2_grnt_),
        .m3_grnt_(m3_grnt_)
    );
    
    bus_master_mux bus_master_mux (
        m0_addr,        //address
        m0_as_,         //address select
        m0_rw,          //read/write
        m0_wr_data,     //the data write in
        m0_grnt_,       //assign bus
        /*number 1 bus master*/
        m1_addr,        //address
        m1_as_,         //address select
        m1_rw,          //read/write
        m1_wr_data,     //the data write in
        m1_grnt_,       //assign bus
        /*number 2 bus master*/
        m2_addr,        //address
        m2_as_,         //address select
        m2_rw,          //read/write
        m2_wr_data,     //the data write in
        m2_grnt_,       //assign bus
        /*number 3 bus master*/
        m3_addr,        //address
        m3_as_,         //address select
        m3_rw,          //read/write
        m3_wr_data,     //the data write in
        m3_grnt_,       //assign bus
        /*share signal bus slave*/
        s_addr,         //address
        s_as_,          //address select
        s_rw,           //read/write
        s_wr_data       //the data write in
    );
    
    bus_addr_dec bus_addr_dec(
        .s_addr(s_addr),
        .s0_cs_(s0_cs_),
        .s1_cs_(s1_cs_),
        .s2_cs_(s2_cs_),
        .s3_cs_(s3_cs_),
        .s4_cs_(s4_cs_),
        .s5_cs_(s5_cs_),
        .s6_cs_(s6_cs_),
        .s7_cs_(s7_cs_)
    );
    
    bus_slave_mux bus_slave_mux(
        .s0_cs_(s0_cs_),
        .s1_cs_(s1_cs_),
        .s2_cs_(s2_cs_),
        .s3_cs_(s3_cs_),
        .s4_cs_(s4_cs_),
        .s5_cs_(s5_cs_),
        .s6_cs_(s6_cs_),
        .s7_cs_(s7_cs_),
        .s0_rdy_(s0_rdy_),
        .s1_rdy_(s1_rdy_),
        .s2_rdy_(s2_rdy_),
        .s3_rdy_(s3_rdy_),
        .s4_rdy_(s4_rdy_),
        .s5_rdy_(s5_rdy_),
        .s6_rdy_(s6_rdy_),
        .s7_rdy_(s7_rdy_),
        .s0_rd_data(s0_rd_data),
        .s1_rd_data(s1_rd_data),
        .s2_rd_data(s2_rd_data),
        .s3_rd_data(s3_rd_data),
        .s4_rd_data(s4_rd_data),
        .s5_rd_data(s5_rd_data),
        .s6_rd_data(s6_rd_data),
        .s7_rd_data(s7_rd_data),
        .m_rd_data(m_rd_data),
        .m_rdy_(m_rdy_)
    );
    

endmodule
