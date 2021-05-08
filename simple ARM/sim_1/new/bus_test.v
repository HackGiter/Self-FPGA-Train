`timescale 1ns / 1ps
`include "bus.vh"
`include "stddef.vh"
`include "global_config.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 16:17:23
// Design Name: 
// Module Name: bus_test
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


module bus_test(

    );
    //time & reset
    reg clk;    //clock
    reg reset_; //reset(negative logic)
    
    //bus master individual signal
    reg     m0_req_;     //request bus
    /*number one bus master*/
    reg     m1_req_;
    /*number two bus master*/
    reg     m2_req_;
    /*number three bus master*/
    reg     m3_req_;
    reg [29:0]  m0_addr;        //address
    reg         m0_as_;         //address select
    reg         m0_rw;          //read/write
    reg [31:0]  m0_wr_data;     //the data write in
    /*number 1 bus master*/
    reg [29:0]  m1_addr;        //address
    reg         m1_as_;         //address select
    reg         m1_rw;          //read/write
    reg [31:0]  m1_wr_data;     //the data write in
    /*number 2 bus master*/
    reg [29:0]  m2_addr;        //address
    reg         m2_as_;         //address select
    reg         m2_rw;          //read/write
    reg [31:0]  m2_wr_data;     //the data write in
    /*number 3 bus master*/
    reg [29:0]  m3_addr;        //address
    reg         m3_as_;         //address select
    reg         m3_rw;          //read/write
    reg [31:0]  m3_wr_data;     //the data write in
    
    /*bus slave share signal*/
    wire [29:0]  s_addr;
    wire         s_as_;
    wire         s_rw;
    wire [31:0]  s_wr_data;
    
    /*bus slave individual signal*/
    wire            s0_cs_;     //chip select
    wire            s1_cs_;     //chip select
    wire            s2_cs_;     //chip select
    wire            s3_cs_;     //chip select
    wire            s4_cs_;     //chip select
    wire            s5_cs_;     //chip select
    wire            s6_cs_;     //chip select
    wire            s7_cs_;      //chip select
    
    reg [31:0]  s0_rd_data; //the data read  
    reg         s0_rdy_;     //ready
    reg [31:0]  s1_rd_data; //the data read  
    reg         s1_rdy_;     //ready
    reg [31:0]  s2_rd_data; //the data read  
    reg         s2_rdy_;     //ready
    reg [31:0]  s3_rd_data; //the data read  
    reg         s3_rdy_;     //ready
    reg [31:0]  s4_rd_data; //the data read  
    reg         s4_rdy_;     //ready
    reg [31:0]  s5_rd_data; //the data read  
    reg         s5_rdy_;     //ready
    reg [31:0]  s6_rd_data; //the data read  
    reg         s6_rdy_;     //ready
    reg [31:0]  s7_rd_data; //the data read  
    reg         s7_rdy_;     //ready;
    
    /*bus master share signal*/
    wire[31:0]  m_rd_data;
    wire        m_rdy_;
    
    /*define simulation circulation*/ 
    parameter       STEP     = 100.0000;    //10 M
    
    
    
    /*generate clock*/
    always #(STEP / 2) begin
        clk <= ~clk;
    end
    
    /*instantiate test module*/
    bus bus(
        clk,        //clock
        /*number zero bus master*/
        reset_,      //asynchronous  reset
        m0_req_,     //request bus
        /*number one bus master*/
        m1_req_,
        /*number two bus master*/
        m2_req_,
        /*number three bus master*/
        m3_req_,
        m0_addr,        //address
        m0_as_,         //address select
        m0_rw,          //read/write
        m0_wr_data,     //the data write in
        /*number 1 bus master*/
        m1_addr,        //address
        m1_as_,         //address select
        m1_rw,          //read/write
        m1_wr_data,     //the data write in
        /*number 2 bus master*/
        m2_addr,        //address
        m2_as_,         //address select
        m2_rw,          //read/write
        m2_wr_data,     //the data write in
        /*number 3 bus master*/
        m3_addr,        //address
        m3_as_,         //address select
        m3_rw,          //read/write
        m3_wr_data,     //the data write in
        s0_rd_data, //the data read  
        s0_rdy_,     //ready
        s1_rd_data, //the data read  
        s1_rdy_,     //ready
        s2_rd_data, //the data read  
        s2_rdy_,     //ready
        s3_rd_data, //the data read  
        s3_rdy_,     //ready
        s4_rd_data, //the data read  
        s4_rdy_,     //ready
        s5_rd_data, //the data read  
        s5_rdy_,     //ready
        s6_rd_data, //the data read  
        s6_rdy_,     //ready
        s7_rd_data, //the data read  
        s7_rdy_,     //ready,
    
        s_addr,         //address
        s_as_,          //address select
        s_rw,           //read/write
        s_wr_data,       //the data write in
        s0_cs_,     //chip select
        s1_cs_,     //chip select
        s2_cs_,     //chip select
        s3_cs_,     //chip select
        s4_cs_,     //chip select
        s5_cs_,     //chip select
        s6_cs_,     //chip select
        s7_cs_,      //chip select
        m_rd_data,  //the data read
        m_rdy_       //ready
    );
    
    /*test example*/
    initial begin
        # 0  begin
            clk <=  `HIGH;
            reset_  <= `ENABLE_;
            m0_wr_data <= 32'h1;
            m0_as_  <= `ENABLE_;
            m0_rw   <= `ENABLE_;
            m0_addr <= 30'h0;
            m0_addr[29:27] <= 2'h0;
            m1_wr_data <= 32'h2;
            m1_as_  <= `ENABLE_;
            m1_rw   <= `ENABLE_;
            m1_addr <= 30'h0;
            m1_addr[29:27] <= 2'h1;
            m2_wr_data <= 32'h3;
            m2_as_  <= `ENABLE_;
            m2_rw   <= `ENABLE_;
            m2_addr <= 30'h0;
            m2_addr[29:27] <= 30'h2;
            m3_wr_data <= 32'h4;
            m3_as_  <= `ENABLE_;
            m3_rw   <= `ENABLE_;
            m3_addr <= 30'h0;
            m3_addr[29:27] <= 2'h3;
            s0_rd_data <= 32'h8;
            s1_rd_data <= 32'h1;
            s2_rd_data <= 32'h2;
            s3_rd_data <= 32'h3;
            s4_rd_data <= 32'h4;
            s5_rd_data <= 32'h5;
            s6_rd_data <= 32'h6;
            s7_rd_data <= 32'h7;
            s0_rdy_ <= `ENABLE;
            s1_rdy_ <= `ENABLE;
            s2_rdy_ <= `ENABLE;
            s3_rdy_ <= `ENABLE;
            s4_rdy_ <= `ENABLE;
            s5_rdy_ <= `ENABLE;
            s6_rdy_ <= `ENABLE;
            s7_rdy_ <= `ENABLE;
            m0_req_ <= `DISABLE_;
            m1_req_ <= `DISABLE_;
            m2_req_ <= `DISABLE_;
            m3_req_ <= `DISABLE_;
        end
    
        #   (STEP * 3 / 4)
        #   STEP begin
            reset_  <= `DISABLE_;   // relieve reset
        end
        
        #   STEP begin
            # (STEP * 2)  m1_req_ <= `ENABLE_;
            # (STEP * 2)  m2_req_ <= `ENABLE_;
            # (STEP * 2)  m3_req_ <= `ENABLE_;
            # (STEP * 2)  m0_req_ <= `ENABLE_;
            # (STEP * 2)  m1_req_ <= `DISABLE_;
            # (STEP * 2)  m2_req_ <= `DISABLE_;
            # (STEP * 2)  m3_req_ <= `DISABLE_;
            # (STEP * 2)  m0_req_ <= `DISABLE_;
            # (STEP * 2)  m3_req_ <= `ENABLE_;
            # (STEP * 2)  m1_req_ <= `ENABLE_;
            # (STEP * 2)  m3_req_ <= `ENABLE_;
            # (STEP * 2)  m0_req_ <= `ENABLE_;
            # (STEP * 2)  m1_req_ <= `DISABLE_;
            # (STEP * 2)  m2_req_ <= `DISABLE_;
            # (STEP * 2)  m3_req_ <= `DISABLE_;
            # (STEP * 2)  m0_req_ <= `DISABLE_;
            # (STEP * 2)  m2_req_ <= `ENABLE_;
            # (STEP * 2)  m1_req_ <= `ENABLE_;
            # (STEP * 2)  m1_req_ <= `ENABLE_;
            # (STEP * 2)  m0_req_ <= `ENABLE_;
        end
        #   (STEP*2) begin
            $finish;    //finish the simulation
        end
    end
    
    
    
endmodule
