`timescale 1ns / 1ps
`include "bus.vh"
`include "cpu.vh"
`include "spm.vh"
`include "global_config.vh"
`include "stddef.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 00:01:49
// Design Name: 
// Module Name: bus_if
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


module bus_if(
/*clock & reset*/
input   wire        clk,        
input   wire        reset,   
 /*pipeline control signal*/
input   wire        stall,
input   wire        flush,          
output  reg         busy,           
/*cpu interface*/
input   wire[29:0]  addr,           
input   wire        as_,            
input   wire        rw,
input   wire[31:0]  wr_data,
output  reg [31:0]  rd_data,
/*spm interface*/
input   wire[31:0]  spm_rd_data,
output  wire[29:0]  spm_addr,
output  reg         spm_as_,
output  wire        spm_rw,
output  wire[31:0]  spm_wr_data,
/*bus interface*/
input   wire[31:0]  bus_rd_data,
input   wire        bus_rdy_,
input   wire        bus_grnt_,
output  reg         bus_req_,
//output  wire[29:0]  bus_addr,
output  reg [29:0]  bus_addr,
output  reg         bus_as_,
//output  wire        bus_rw,
//output  wire[31:0]  bus_wr_data  
output  reg         bus_rw,
output  reg [31:0]  bus_wr_data  
    );
    reg [1:0]       state;
    reg [31:0]      rd_buf;
    wire[2:0]       s_index;
    
    assign  s_index     =   addr[`BusSlaveIndexLoc];        //generate the bus slave index
    
    /*the assignment of output*/
    /*default output*/
    assign  spm_addr        =   addr;
    assign  spm_rw          =   rw;
    assign  spm_wr_data     =   wr_data;
    
    /*THE CONTROL OF MEMORY ACCESS*/
    always @(*) begin
        /*dafault*/
        rd_data     =   `WORD_DATA_W'h0;
        spm_as_     =   `DISABLE_;
        busy        =   `DISABLE_;
        /*THE STATUS OF BUS INTERFACE*/
        case (state)
            `BUS_IF_STATE_IDLE      : begin //spare or free
                /*memory access*/
                if ((flush == `DISABLE) && (as_ == `ENABLE_)) begin
                    /*the target to choose to access*/
                    if (s_index == `BUS_SLAVE_1) begin  //access the SPM
                        if (stall == `DISABLE) begin //detect the occurs of delay
                            spm_as_ = `ENABLE_;
                            if (rw == `READ) begin  //read access
                                rd_data = spm_rd_data;
                            end
                        end
                    end else begin
                        busy    = `ENABLE;
                    end
                end
            end
            `BUS_IF_STATE_REQ   : begin
                busy = `ENABLE;
            end
            `BUS_IF_STATE_ACCESS : begin // BUS ACCESS
            /*awaite the ready signal*/
                if (bus_rdy_ == `ENABLE_) begin //ready signal is on
                    if (rw == `READ) begin  //read access
                        rd_data = bus_rd_data;
                    end
                end else begin  //ready signal not approach
                    busy = `ENABLE;
                end
            end
            `BUS_IF_STATE_STALL : begin //delay
                if (rw == `READ) begin  //read access
                    rd_data = rd_buf;
                end
            end
        endcase
    end
    
    /*the statue control of bus interface */
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            /*ASYNCHRONOUS RESET*/
            state           <= #1 `BUS_IF_STATE_IDLE;
            bus_req_        <= #1 `DISABLE_;
            bus_addr        <= #1 `WORD_ADDR_W'h0;
            bus_as_         <= #1 `DISABLE_;
            bus_rw          <= #1 `READ;
            bus_wr_data     <= #1 `WORD_DATA_W'h0;
            rd_buf          <= #1 `WORD_DATA_W'h0;
        end else begin
            /*state of bus interface*/
            case (state)
                `BUS_IF_STATE_IDLE  : begin //spare or free
                    /*MEMORY ACCESS*/
                    if ((flush == `DISABLE) && (as_ == `ENABLE_)) begin
                        /*select the access target*/
                        if (s_index != `BUS_SLAVE_1) begin  //access bus
                            state       <= #1 `BUS_IF_STATE_REQ;
                            bus_req_    <= #1 `ENABLE;
                            bus_addr    <= #1 addr;
                            bus_rw      <= #1 rw;
                            bus_wr_data <= #1 wr_data;
                        end
                    end
                end
                `BUS_IF_STATE_REQ   : begin //REQUEST BUS
                    /*AWAIT ADMINISTRATION OF BUS*/
                    if ((bus_grnt_ == `ENABLE_)) begin
                        state       <= #1 `BUS_IF_STATE_ACCESS;
                        bus_as_     <= #1 `ENABLE_;
                    end
                end
                `BUS_IF_STATE_ACCESS    : begin //ACCESS BUS
                    /*make address-select disable*/
                    bus_as_     <= #1 `DISABLE_;
                    /*AWAIT for ready signal*/
                    if (bus_rdy_ == `ENABLE_) begin
                        bus_req_        <= #1 `DISABLE_;
                        bus_addr        <= #1 `WORD_ADDR_W'h0;
                        bus_rw          <= #1 `READ;
                        bus_wr_data     <= #1 `WORD_DATA_W'h0;
                        /*preserve the data read*/
                        if (bus_rw == `READ) begin
                            rd_buf      <= #1 bus_rd_data;
                        end
                        /*detect where occur delay or not*/
                        if (stall == `ENABLE) begin //OCCUR DELAY
                            state       <= #1 `BUS_IF_STATE_STALL;
                        end else begin  //NOT OCCUR DELAY
                            state       <= #1 `BUS_IF_STATE_IDLE;
                        end
                    end
                end
                `BUS_IF_STATE_STALL : begin //DELAY
                    /*DETECT WHETHER OCCUR DELAY OR NOT*/
                    if (stall == `DISABLE) begin    //RELEASE DELAY
                        state       <= #1 `BUS_IF_STATE_IDLE;
                    end
                end
            endcase
        end
    end
    
    
endmodule
