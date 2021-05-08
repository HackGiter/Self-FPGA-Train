`timescale 1ns / 1ps
`include    "timer.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/07 13:04:27
// Design Name: 
// Module Name: timer
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


module timer(
/*Clock & Reset*/
input   wire            clk,
input   wire            reset,
/*Bus Interface*/
input   wire            cs_,
input   wire            as_,
input   wire            rw,
input   wire[1:0]       addr,
input   wire[31:0]      wr_data,
output  reg [31:0]      rd_data,
output  reg             rdy_,
output  reg             irq_
    );
    reg         irq;
    reg         mode;
    reg         start;
    reg [31:0]  expr_val;
    reg [31:0]  counter;
    
    /*timer complete tag*/
    wire    expr_flag       =   ((start  ==  `ENABLE)    &&  (counter    ==  expr_val)) ? 
                            `ENABLE   :   `DISABLE;
                            
    /*timer control*/
    always  @(posedge clk   or  `RESET_EDGE reset)  begin
        if (reset   ==  `RESET_ENABLE) begin
            /*Asynchronous Reset*/
            rd_data         <=  #1  `WORD_DATA_W'h0;
            rdy_            <=  #1  `DISABLE_;
            start           <=  #1  `DISABLE;
            mode            <=  #1  `TIMER_MODE_ONE_SHOT;
            irq             <=  #1  `DISABLE;
            expr_val        <=  #1  `WORD_DATA_W'h0;
            counter         <=  #1  `WORD_DATA_W'h0;
        end else begin
            /*the generate of ready signal*/
            if  ((cs_   ==  `ENABLE_)   &&  (as_    ==  `ENABLE_))  begin
                rdy_        <=  #1  `ENABLE_;
            end else begin
                rdy_        <=  #1  `DISABLE_;
            end
            /*read access*/
            if  ((cs_   ==  `ENABLE)    &&  (as_    ==  `ENABLE_)   &&  (rw ==  `READ)) begin
                case    (addr)
                    `TIMER_ADDR_CTRL        :   begin
                        rd_data     <=  #1  {{`WORD_DATA_W-2{1'b0}}, mode, start};
                    end
                    `TIMER_ADDR_INTR        :   begin
                        rd_data     <=  #1  {{`WORD_DATA_W-1{1'b0}}, irq};
                    end
                    `TIMER_ADDR_EXPR        :   begin
                        rd_data     <=  #1  expr_val;
                    end
                    `TIMER_ADDR_COUNTER     :   begin
                        rd_data     <=  #1  counter;
                    end
                endcase
            
            end else begin
                rd_data     <=  #1  counter;
            end
            /*write in access*/
            if ((cs_    ==  `ENABLE_)   &&  (as_    ==  `ENABLE_)   &&
                (rw     ==  `WRITE) &&  (addr   ==  `TIMER_ADDR_CTRL))  begin
            end else if ((expr_flag ==  `ENABLE)    &&
                            (mode   ==  `TIMER_MODE_ONE_SHOT)) begin
                start       <=  #1  `DISABLE;
            end
            /*Control Register  1*/
            if  (expr_flag  ==  `ENABLE)    begin
                irq     <=  #1  `ENABLE;
            end else if ((cs_   ==  `ENABLE_)   &&  (as_    ==  `ENABLE_)   &&
                    (rw ==`WRITE)   &&  (addr   ==  `TIMER_ADDR_INTR))  begin
                irq     <=  #1  wr_data[`TimerIrqLoc];        
            end
            /*Control Register  2*/
            if  ((cs_   ==  `ENABLE_)   &&  (as_    ==  `ENABLE_)   &&
                (rw ==  `WRITE)  &&  (addr  ==  `TIMER_ADDR_INTR))  begin
                expr_val        <=  #1  wr_data;
            end
            /*Control Register  3*/
            if  ((cs_   ==  `ENABLE_)   &&  (as_    ==  `ENABLE_)   &&
                (rw ==  `WRITE) &&  (addr   ==  `TIMER_ADDR_COUNTER)) begin
                counter     <=  #1  wr_data;
            end else if (expr_flag  ==  `ENABLE)  begin
                counter     <=  #1  `WORD_DATA_W'h0;
            end else if (start  ==  `ENABLE)  begin
                counter     <=  #1  counter +   1'b1;
            end
        end
    end
                            
                            
endmodule












