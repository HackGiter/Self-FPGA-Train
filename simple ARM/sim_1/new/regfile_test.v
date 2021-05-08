`timescale 1ns / 1ps
`include "regfile.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 10:38:36
// Design Name: 
// Module Name: regfile_test
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


module regfile_test(
    
    );
    /*输入输出端口信号*/
    //时钟&复位
    reg clk;    //clock
    reg reset_; //reset(negative logic)
    //access interface
    reg  [`AddrBus]  addr;   //address
    reg  [`DataBus]  d_in;   //input data
    reg             we_;    //write enable(negative logic)
    wire [`DataBus] d_out;  //output data
    /*internal variant*/
    integer         i;      //iterator
    /*define simulation circulation*/ 
    parameter       STEP     = 100.0000;    //10 M
    
    /*generate clock*/
    always #(STEP / 2) begin
        clk <= ~clk;
    end
    
    /*instantiate test module*/
    regfile regfile (
        /*clock & reset*/
        .clk    (clk),  //clock
        .reset_ (reset_),   //reset(negative logic)
        /*access interface*/
        .addr   (addr), //address
        .d_in   (d_in), //input data
        .we_    (we_),  //write enable(negative logic)
        .d_out  (d_out) //output data
    );
    
    /*test example*/
    initial begin
        # 0  begin
            clk <=  `HIGH;
            reset_  <= `ENABLE_;
            addr    <=  {`ADDR_W{1'b0}};
            d_in    <=  {`DATA_W{1'b0}};    //{repeat times{repeated datas}} or {repeateddata1, repeateddata2,...}
            we_     <=  `DISABLE_;
        end
    
        #   (STEP * 3 / 4)
        #   STEP begin
            reset_  <= `DISABLE_;   // relieve reset
        end
        
        #   STEP begin
            for (i = 0; i < `DATA_D; i = i + 1) begin
                #   STEP begin
                    addr    <= i;
                    d_in    <= i;
                    we_     <= `ENABLE_;
                end
                #   STEP begin
                    addr    <= {`ADDR_W{1'b0}};
                    d_in    <= {`DATA_W{1'b0}};
                    we_     <= `DISABLE_;
                    if (d_out == i) begin
                        $display($time, " ff[%d] Read/Write Check OK !", i);
                    end else begin
                        $display($time, " ff[%d] Read/Write Check NG", i);
                    end
                end
            end
        end
        #   STEP begin
            $finish;    //finish the simulation
        end
    end
    
    /*输出波形*/
    initial begin
        $dumpfile("regfile.vcd");   //output waveform
        $dumpvars(0, regfile);
    end
    
endmodule
