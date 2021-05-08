`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 21:42:32
// Design Name: 
// Module Name: bus_slave_mux
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


module bus_slave_mux(
input   wire        s0_cs_,     //chip select
input   wire[31:0]  s0_rd_data, //the data read  
input   wire        s0_rdy_,     //ready
input   wire        s1_cs_,     //chip select
input   wire[31:0]  s1_rd_data, //the data read  
input   wire        s1_rdy_,     //ready
input   wire        s2_cs_,     //chip select
input   wire[31:0]  s2_rd_data, //the data read  
input   wire        s2_rdy_,     //ready
input   wire        s3_cs_,     //chip select
input   wire[31:0]  s3_rd_data, //the data read  
input   wire        s3_rdy_,     //ready
input   wire        s4_cs_,     //chip select
input   wire[31:0]  s4_rd_data, //the data read  
input   wire        s4_rdy_,     //ready
input   wire        s5_cs_,     //chip select
input   wire[31:0]  s5_rd_data, //the data read  
input   wire        s5_rdy_,     //ready
input   wire        s6_cs_,     //chip select
input   wire[31:0]  s6_rd_data, //the data read  
input   wire        s6_rdy_,     //ready
input   wire        s7_cs_,      //chip select
input   wire[31:0]  s7_rd_data, //the data read  
input   wire        s7_rdy_,     //ready
output  reg [31:0]  m_rd_data,  //the data read
output  reg         m_rdy_       //ready
    );
    /*bus slave mutiplexity*/
    always  @(*)    begin
        /*select the slave corresponding to chip select signal*/
        if (s0_cs_ == `ENABLE_) begin
            m_rd_data   =   s0_rd_data;
            m_rdy_      =   s0_rdy_;
        end else if (s1_cs_ == `ENABLE_) begin
            m_rd_data   =   s1_rd_data;
            m_rdy_      =   s1_rdy_;
        end else if (s2_cs_ == `ENABLE_) begin
            m_rd_data   =   s2_rd_data;
            m_rdy_      =   s2_rdy_;
        end else if (s3_cs_ == `ENABLE_) begin
            m_rd_data   =   s3_rd_data;
            m_rdy_      =   s3_rdy_;
        end else if (s4_cs_ == `ENABLE_) begin
            m_rd_data   =   s4_rd_data;
            m_rdy_      =   s4_rdy_;
        end else if (s5_cs_ == `ENABLE_) begin
            m_rd_data   =   s5_rd_data;
            m_rdy_      =   s5_rdy_;
        end else if (s6_cs_ == `ENABLE_) begin
            m_rd_data   =   s6_rd_data;
            m_rdy_      =   s6_rdy_;
        end else if (s7_cs_ == `ENABLE_) begin
            m_rd_data   =   s7_rd_data;
            m_rdy_      =   s7_rdy_;
        end else begin
            m_rd_data   =   `WORD_DATA_W'h0;
            m_rdy_      =   `DISABLE_;
        end
    end
endmodule
