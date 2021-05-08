`timescale 1ns / 1ps
`include "isa.vh"
`include "stddef.vh"
`include "global_config.vh"
`include "cpu.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 15:40:32
// Design Name: 
// Module Name: alu
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


module alu(
/*Input*/
input   wire[31:0]      in_0,
input   wire[31:0]      in_1,
input   wire[3:0]       op,
/*Operation Result*/
output  reg [31:0]      out,
output  reg             of
    );
    /*Signed Input and Output Signal*/
    wire signed [`WordDataBus]  s_in_0  =   $signed(in_0);      //Signed input 0
    wire signed [`WordDataBus]  s_in_1  =   $signed(in_1);      //Signed input 1
    wire signed [`WordDataBus]  s_out   =   $signed(out);       //Signed output
    
    /*Arithmetic Logic Operation*/
    always @(*) begin
        case (op)
            `ALU_OP_AND :   begin   //Logic and
                out     =   in_0 & in_1;
            end
            `ALU_OP_OR  :   begin   //Logic or
                out     =   in_0 & in_1;
            end
            `ALU_OP_XOR :   begin   //Logic xor
                out     =   in_0 ^ in_1;
            end
            `ALU_OP_ADDS:   begin   //signed add
                out     =   in_0 + in_1;
            end
            `ALU_OP_ADDU:   begin   //unsigned add
                out     =   in_0 + in_1;
            end
            `ALU_OP_SUBS:   begin   //unsigned signed
                out     =   in_0 - in_1;
            end
            `ALU_OP_SUBU:   begin   //unsigned subtract
                out     =   in_0 - in_1;
            end
            `ALU_OP_SHRL:   begin   //Logic right shrift
                out     =   in_0 >> in_1[`ShAmountLoc];
            end
            `ALU_OP_SHLL:   begin   //Logic left shrift
                out     =   in_0 << in_1[`ShAmountLoc];
            end
            default         begin   //No Operation
                out     =   in_0;
            end
        endcase
    end
    
    /*detect overflow*/
    always @(*) begin
        case (op)
            `ALU_OP_ADDS    :   begin
                if (((s_in_0 > 0) && (s_in_1 > 0) && (s_out < 0)) || 
                    ((s_in_0 <0) && (s_in_1 < 0) && (s_out > 0))) begin
                    of      =   `ENABLE;
                end else begin
                    of      =   `DISABLE;
                end
            end
            `ALU_OP_SUBS    :   begin
                if (((s_in_0 < 0) && (s_in_1 > 0) && (s_out > 0)) || 
                    ((s_in_0 > 0) && (s_in_1 < 0) && (s_out < 0))) begin
                    of      =   `ENABLE;
                end else begin
                    of      =   `DISABLE;
                end
            end
            default         :   begin
                of      =   `DISABLE;
            end
        endcase
    end
    
endmodule
