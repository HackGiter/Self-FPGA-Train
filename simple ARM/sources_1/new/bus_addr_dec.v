`timescale 1ns / 1ps
`include    "global_config.vh"
`include    "stddef.vh"
`include    "bus.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 20:55:43
// Design Name: 
// Module Name: bus_addr_dec
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


module bus_addr_dec(
input   wire[29:0]      s_addr,     //address
output  reg             s0_cs_,     //chip select
output  reg             s1_cs_,     //chip select
output  reg             s2_cs_,     //chip select
output  reg             s3_cs_,     //chip select
output  reg             s4_cs_,     //chip select
output  reg             s5_cs_,     //chip select
output  reg             s6_cs_,     //chip select
output  reg             s7_cs_      //chip select
    );
    /*bus slave index*/
    wire[`BusSlaveIndexBus]   s_index   =   s_addr[`BusSlaveIndexLoc];        //bus slave index
    
    /*bus slaves multiplexity*/
    always @(*) begin
    /*initiate the chip select signal*/
        s0_cs_  =   `DISABLE_;
        s1_cs_  =   `DISABLE_;
        s2_cs_  =   `DISABLE_;
        s3_cs_  =   `DISABLE_;
        s4_cs_  =   `DISABLE_;
        s5_cs_  =   `DISABLE_;
        s6_cs_  =   `DISABLE_;
        s7_cs_  =   `DISABLE_;
        /*select address corresponding to the slave*/
        case (s_index)
            `BUS_SLAVE_0    :   begin
                s0_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_1    :   begin
                s1_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_2    :   begin
                s2_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_3    :   begin
                s3_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_4    :   begin
                s4_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_5    :   begin
                s5_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_6    :   begin
                s6_cs_  =   `ENABLE_;
            end
            `BUS_SLAVE_7    :   begin
                s7_cs_  =   `ENABLE_;
            end
        endcase
    end
    
endmodule
