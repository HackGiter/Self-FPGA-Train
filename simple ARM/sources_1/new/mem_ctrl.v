`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 16:39:27
// Design Name: 
// Module Name: mem_ctrl
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


module mem_ctrl(
/*EX/MEM Pipeline Register*/
input   wire        ex_en,
input   wire[1:0]   ex_mem_op,
input   wire[31:0]  ex_mem_wr_data,
input   wire[31:0]  ex_out,
/*Memory Access Interface*/
input   wire[31:0]  rd_data,
output  wire[29:0]  addr,
output  reg         as_,
output  reg         rw,
output  wire[31:0]  wr_data,
/*result of memory access*/
output  reg [31:0]  out,
output  reg         miss_align

    );
    /*assignment of output*/
    assign wr_data      =   ex_mem_wr_data;
    assign addr         =   ex_out[`WordAddrLoc];
    assign offset       =   ex_out[`ByteOffsetLoc];
    
    /*Control of Memory Access*/
    always @(*) begin
        /*default*/
        miss_align      =   `DISABLE;
        out             =   `WORD_DATA_W'h0;
        as_             =   `DISABLE_;
        rw              =   `READ;
        /*Memory Access*/
        if (ex_en == `ENABLE) begin
            case (ex_mem_op)
                `MEM_OP_LDW :   begin
                    /* the detection bytee offset*/
                    if (offset  ==  `BYTE_OFFSET_WORD)  begin
                        out     =   rd_data;
                        as_     =   `ENABLE_;
                    end else begin
                        miss_align  =   `ENABLE;    
                    end
                end
                `MEM_OP_STW :   begin
                    /*the detection of byte offset*/
                    if (offset  ==  `BYTE_OFFSET_WORD)  begin
                        rw      =   `WRITE;
                        as_     =   `ENABLE_;
                    end else begin
                        miss_align  =   `ENABLE;
                    end
                end
                default     :   begin
                    out         =   ex_out;
                end
            endcase
        end
        
    end
endmodule
