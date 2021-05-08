`timescale 1ns / 1ps
`include    "regfile.vh"
`include    "bus.vh"
`include    "global_config.vh"
`include    "stddef.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 16:10:28
// Design Name: 
// Module Name: bus_arbiter
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

/*round robinÂÖÑ¯»úÖÆ*/
module bus_arbiter(
input   wire    clk,        //clock
/*number zero bus master*/
input   wire    reset,      //asynchronous  reset
input   wire    m0_req_,     //request bus
output   reg    m0_grnt_,    //assign bus
/*number one bus master*/
input   wire    m1_req_,
output   reg    m1_grnt_,
/*number two bus master*/
input   wire    m2_req_,
output   reg    m2_grnt_,
/*number three bus master*/
input   wire    m3_req_,
output   reg    m3_grnt_
    );
    /*internal signal*/
    reg [1:0]   owner;  //  bus usufruct owner
    
    /*arbitration of the ownership of bus*/
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            /*asychronous reset*/
            owner <= #1 `BUS_OWNER_MASTER_0;
        end else begin
            /*arbitration*/
            case (owner)
                `BUS_OWNER_MASTER_0 :   begin   // bus master number 0
                    /* the next bus master acquired bus ownership*/
                    if (m0_req_ == `ENABLE_) begin  //bus master number 0
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end else if (m1_req_ == `ENABLE_) begin // bus master number 1
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end else if (m2_req_ == `ENABLE_) begin // bus master number 2
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end else if (m3_req_ == `ENABLE_) begin // bus master number 3
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end
                end
                `BUS_OWNER_MASTER_1 :   begin   // bus master number 1
                    /* the next bus master acquired bus ownership*/
                    if (m1_req_ == `ENABLE_) begin  //bus master number 1
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end else if (m2_req_ == `ENABLE_) begin // bus master number 2
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end else if (m3_req_ == `ENABLE_) begin // bus master number 3
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end else if (m0_req_ == `ENABLE_) begin // bus master number 0
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                end
                `BUS_OWNER_MASTER_2 :   begin   // bus master number 2
                    /* the next bus master acquired bus ownership*/
                    if (m2_req_ == `ENABLE_) begin  //bus master number 2
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end else if (m3_req_ == `ENABLE_) begin // bus master number 3
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end else if (m0_req_ == `ENABLE_) begin // bus master number 0
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end else if (m1_req_ == `ENABLE_) begin // bus master number 1
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end
                end
                `BUS_OWNER_MASTER_3 :   begin   // bus master number 3
                    /* the next bus master acquired bus ownership*/
                    if (m3_req_ == `ENABLE_) begin  //bus master number 3
                        owner <= #1 `BUS_OWNER_MASTER_3;
                    end else if (m0_req_ == `ENABLE_) begin // bus master number 0
                        owner <= #1 `BUS_OWNER_MASTER_0;
                    end else if (m1_req_ == `ENABLE_) begin // bus master number 1
                        owner <= #1 `BUS_OWNER_MASTER_1;
                    end else if (m2_req_ == `ENABLE_) begin // bus master number 2
                        owner <= #1 `BUS_OWNER_MASTER_2;
                    end
                end
            endcase
        end
    end
    
    /*assign bus right to use*/
    always @(*) begin
        /*initiate the right to use of bus*/
        m0_grnt_ = `DISABLE_;   
        m1_grnt_ = `DISABLE_;
        m2_grnt_ = `DISABLE_;
        m3_grnt_ = `DISABLE_;
        /*assign bus right to use*/
        case (owner)
            `BUS_OWNER_MASTER_0 : begin
                m0_grnt_ = `ENABLE_;    //bus master 0
            end
            `BUS_OWNER_MASTER_1 : begin
                m1_grnt_ = `ENABLE_;    //bus master 1
            end
            `BUS_OWNER_MASTER_2 : begin
                m2_grnt_ = `ENABLE_;    //bus master 2
            end
            `BUS_OWNER_MASTER_3 : begin
                m3_grnt_ = `ENABLE_;    //bus master 3
            end
        endcase
    end
endmodule
