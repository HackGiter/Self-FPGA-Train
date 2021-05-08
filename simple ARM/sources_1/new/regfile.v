`timescale 1ns / 1ps
 `include "regfile.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 10:12:20
// Design Name: 
// Module Name: regfile
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


module regfile(
    /*Clock reset*/
    input   wire  clk,    // ±÷”
    input   wire  reset_, //Asynchronous reset
    /*Access interface*/
    input   wire [`AddrBus] addr,   //  address
    input   wire [`DataBus] d_in,   //  input data
    input   wire            we_,    //  Write enable(Negative Logic)
    output  wire [`DataBus] d_out   //  Output Data
    );
    
    /*internal signal*/
    reg [`DataBus]  ff  [`DATA_D-1:0];  //  Register Sequence
    integer         i;                  //  iterator
    
    /*read access*/
    assign  d_out   =   ff[addr];
    
    /*write access*/
    always  @(posedge clk or negedge reset_) begin
        if (reset_ == `ENABLE_) begin
            /* asynchronous reset*/
            for (i = 0; i < `DATA_D; i = i + 1) begin
                ff[i]   <=  #1 {`DATA_W{1'b0}};
            end
        end else begin
        /*write access*/
            if (we_ == `ENABLE_) begin
                ff[addr] <= #1  d_in;
            end
        end
    end
    
endmodule
