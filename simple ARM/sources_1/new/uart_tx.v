`timescale 1ns / 1ps
`include    "uart.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/07 17:05:24
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
/*Clock and Reset*/
input   wire        clk,
input   wire        reset,
/*Control Signal*/
input   wire        tx_start,
input   wire[7:0]   tx_data,
output  wire        tx_busy,
output  reg         tx_end,
/*UART Send Signal*/
output  reg         tx
    );
    reg         state;
    reg [8:0]   div_cnt;
    reg [3:0]   bit_cnt;
    reg [7:0]   sh_reg;
    
    /*the generation of send tag signal*/
    assign  tx_busy =   (state  ==  `UART_STATE_TX) ?   `ENABLE :   `DISABLE;
    
    /*Send Logic Circuit*/
    always  @(posedge   clk or  `RESET_EDGE reset)  begin
        if  (reset  ==  `RESET_ENABLE)  begin
            /*Asynchronous Reset*/
            state       <=  #1  `UART_STATE_IDLE;
            div_cnt     <=  #1  `UART_DIV_RATE;
            bit_cnt     <=  #1  `UART_BIT_CNT_START;
            sh_reg      <=  #1  `BYTE_DATA_W'h0;
            tx_end      <=  #1  `DISABLE;
            tx          <=  #1  `UART_STOP_BIT;
        end else begin
            /*Message Status*/
            case    (state)
                `UART_STATE_IDLE    :   begin
                    if (tx_start    ==  `ENABLE)    begin
                        state       <=  #1  `UART_STATE_TX;
                        sh_reg      <=  #1  tx_data;
                        tx          <=  #1  `UART_START_BIT;
                    end
                end
                `UART_STATE_TX    :   begin
                end
            endcase
        end
    end
    
    
endmodule
