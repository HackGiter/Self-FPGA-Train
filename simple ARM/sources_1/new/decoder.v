`timescale 1ns / 1ps
`include "isa.vh"
`include "stddef.vh"
`include "global_config.vh"
`include "cpu.vh"
`include "isa.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/25 11:04:52
// Design Name: 
// Module Name: decoder
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


module decoder(
/*IF/ID Pipeline Register*/
input   wire[29:0]  if_pc,
input   wire[31:0]  if_insn,
input   wire        if_en,
/*GPR Interfare*/
input   wire[31:0]  gpr_rd_data_0,
input   wire[31:0]  gpr_rd_data_1,
output  wire[4:0]   gpr_rd_addr_0,
output  wire[4:0]   gpr_rd_addr_1,
/*the data straight through from ID stage*/
input   wire        id_en,
input   wire[4:0]   id_dst_addr,
input   wire        id_gpr_we_,
input   wire[1:0]   id_mem_op,
/*the data straight through from EX stage*/
input   wire        ex_en,
input   wire[4:0]   ex_dst_addr,
input   wire        ex_gpr_we_,
input   wire[31:0]  ex_fwd_data,
/*the data straight throught from MEM stage*/
input   wire[31:0]  mem_fwd_data,
/*the Control Register Interface*/
input   wire        exe_mode,
input   wire[31:0]  creg_rd_data,
output  wire[4:0]   creg_rd_addr,
/*decode result*/
output  reg [3:0]   alu_op,
output  reg [31:0]  alu_in_0,
output  reg [31:0]  alu_in_1,
output  reg [29:0]  br_addr,
output  reg         br_taken,
output  reg         br_flag,
output  reg [1:0]   mem_op,
output  wire[31:0]  mem_wr_data,
output  reg [1:0]   ctrl_op,
output  reg [4:0]   dst_addr,
output  reg         gpr_we_,
output  reg [2:0]   exp_code,
output  reg         ld_hazard
    );
    /*the Command field*/
//    wire[5:0]   op;
//    wire[4:0]   ra_addr;
//    wire[4:0]   rb_addr;
//    wire[4:0]   rc_addr;
//    wire[15:0]  imm;
//    /*immediate*/
//    wire[31:0]  imm_s;
//    wire[31:0]  imm_u;
//    /*the data accessed from general register*/
//    reg [31:0]  ra_data;
//    wire signed [31:0]  s_ra_data;
//    reg [31:0]  rb_data;
//    wire signed [31:0]  s_rb_data;
//    /*Address*/
//    wire[29:0]  ret_addr;
//    wire[29:0]  br_target;
//    wire[29:0]  jr_target;
    
    /*instruction field*/
    wire[`IsaOpBus]     op      =   if_insn[`IsaOpLoc];     //Operation code
//    wire[5:0]     op      =   if_insn[31:26];     //Operation code
    wire[`RegAddrBus]   ra_addr =   if_insn[`IsaRaAddrLoc]; //Ra Address
    wire[`RegAddrBus]   rb_addr =   if_insn[`IsaRbAddrLoc]; //Rb Address
    wire[`RegAddrBus]   rc_addr =   if_insn[`IsaRcAddrLoc]; //Rc Address
    wire[`IsaImmBus]    imm     =   if_insn[`IsaImmLoc];    //Immediate
    /*Immediate*/
    //Symbol expansion
    wire[`WordDataBus]  imm_s   =   {{`ISA_EXT_W{imm[`ISA_IMM_MSB]}}, imm};
    //0 expansion
    wire[`WordDataBus]  imm_u   =   {{`ISA_EXT_W{1'b0}}, imm};
    /*Register Access Address*/
    assign  gpr_rd_addr_0   =   ra_addr;    // general register access address 0
    assign  gpr_rd_addr_1   =   rb_addr;    // general register access address 1
    assign  creg_rd_addr    =   ra_addr;    // control register access address
    /*the data accessed from General Register*/
    reg [`WordDataBus]  ra_data;    //unsigned Ra
    wire signed [`WordDataBus]  s_ra_data   =   $signed(ra_data);   //signed Ra
    reg [`WordDataBus]  rb_data;    // unsigned Rb
    wire signed [`WordDataBus]  s_rb_data   =   $signed(rb_data);       //signed Rb
    assign  mem_wr_data     =   rb_data;
    /*µÿ÷∑*/  // generation of address
    wire[`WordAddrBus]  ret_addr    =   if_pc + 1'b1;       //the returned address
    wire[`WordAddrBus]  br_target   =   if_pc + imm_s[`WORD_ADDR_MSB:0];    //the target address of branch
    wire[`WordAddrBus]  jr_target   =   ra_data[`WordAddrLoc];      //the jump target address
    
    /*the straight through data*/
    always @(*) begin
        /*Ra Register*/
        if ((id_en == `ENABLE) && (id_gpr_we_ == `ENABLE_) && 
                (id_dst_addr == ra_addr)) begin
            ra_data = ex_fwd_data;      //the data straight throught from EX stage
        end else if ((ex_en == `ENABLE) && (ex_gpr_we_ == `ENABLE_) && 
                (ex_dst_addr == ra_addr)) begin
            ra_data = mem_fwd_data;     //the data straight throught from MEM stage
        end else begin
            ra_data = gpr_rd_data_0;    //access from regsiter heap
        end
        /*Rb Register*/
        if ((id_en == `ENABLE) && (id_gpr_we_ == `ENABLE_) && 
                (id_dst_addr == rb_addr)) begin
            rb_data = ex_fwd_data;          //the data straight throught from EX stage
        end else if ((ex_en == `ENABLE) && (ex_gpr_we_ == `ENABLE) && 
                (ex_dst_addr == rb_addr)) begin
            rb_data = mem_fwd_data;         //the data straight throught from MEM stage
        end else begin
            rb_data = gpr_rd_data_1;        //access from register heap
        end    
    end
    
    /*Load Advanture detect*/
    always @(*) begin
        if ((id_en == `ENABLE) && (id_mem_op == `MEM_OP_LDW) && 
        ((id_dst_addr == ra_addr) || (id_dst_addr == rb_addr))) begin
            ld_hazard = `ENABLE;        //Load Advanture
        end else begin
            ld_hazard = `DISABLE;       //Advanture not happen
        end
    end
    
    /*Instruction decode*/
    always @(*) begin
        /*default*/
        alu_op      =   `ALU_OP_NOP;
        alu_in_0    =   ra_data;
        alu_in_1    =   rb_data;
        br_taken    =   `DISABLE;
        br_flag     =   `DISABLE;
        br_addr     =   {`WORD_ADDR_W{1'b0}};
        mem_op      =   `MEM_OP_NOP;
        ctrl_op     =   `CTRL_OP_NOP;
        dst_addr    =   rb_addr;
        gpr_we_     =   `DISABLE_;
        exp_code    =   `ISA_EXP_NO_EXP;
        
        case (op)
            /*Logic Operation Instruction*/
            `ISA_OP_ANDR    : begin
                alu_op      =   `ALU_OP_AND;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ANDI    : begin
                alu_op      =   `ALU_OP_AND;
                dst_addr    =   imm_u;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ORR     : begin
                alu_op      =   `ALU_OP_OR;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ORI     : begin
                alu_op      =   `ALU_OP_OR;
                dst_addr    =   imm_u;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_XORR    : begin
                alu_op      =   `ALU_OP_XOR;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_XORI    : begin
                alu_op      =   `ALU_OP_XOR;
                dst_addr    =   imm_u;
                gpr_we_     =   `ENABLE_;
            end
            /*Arithmatic Operation Instruction*/
            `ISA_OP_ADDSR   : begin
                alu_op      =   `ALU_OP_ADDS;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ADDSI   : begin
                alu_op      =   `ALU_OP_ADDS;
                dst_addr    =   imm_s;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ADDUR    : begin
                alu_op      =   `ALU_OP_ADDU;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_ADDUI    : begin
                alu_op      =   `ALU_OP_ADDU;
                dst_addr    =   imm_s;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_SUBSR    : begin
                alu_op      =   `ALU_OP_SUBS;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_SUBUR    : begin
                alu_op      =   `ALU_OP_SUBU;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            /*Shift Instruction*/
            `ISA_OP_SHRLR   : begin
                alu_op      =   `ALU_OP_SHRL;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_SHRLI   : begin
                alu_op      =   `ALU_OP_SHRL;
                dst_addr    =   imm_u;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_SHLLR   : begin
                alu_op      =   `ALU_OP_SHLL;
                dst_addr    =   rc_addr;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_SHLLI   : begin
                alu_op      =   `ALU_OP_SHLL;
                dst_addr    =   imm_u;
                gpr_we_     =   `ENABLE_;
            end
            /*Branch Instruction*/
            `ISA_OP_BE   : begin
                br_addr     =   br_target;
                br_taken    =   (ra_data == rb_data) ? `ENABLE : `DISABLE;
                br_flag     =   `ENABLE;
            end
            `ISA_OP_BNE   : begin
                br_addr     =   br_target;
                br_taken    =   (ra_data != rb_data) ? `ENABLE : `DISABLE;
                br_flag     =   `ENABLE;
            end
            `ISA_OP_BSGT   : begin
                br_addr     =   br_target;
                br_taken    =   (s_ra_data < s_rb_data) ? `ENABLE : `DISABLE;
                br_flag     =   `ENABLE;
            end
            `ISA_OP_BUGT   : begin
                br_addr     =   br_target;
                br_taken    =   (ra_data < rb_data) ? `ENABLE : `DISABLE;
                br_flag     =   `ENABLE;
            end
            `ISA_OP_JMP    : begin
                br_addr     =   jr_target;
                br_taken    =   `ENABLE;
                br_flag     =   `ENABLE;
            end
            `ISA_OP_CALL    : begin
                alu_in_0    = {ret_addr, {`BYTE_OFFSET_W{1'b0}}};
                br_addr     =   jr_target;
                br_taken    =   `ENABLE;
                br_flag     =   `ENABLE;
                dst_addr    =   `REG_ADDR_W'd31;
                gpr_we_     =   `ENABLE_;
            end
            /*memory access instruction*/
            `ISA_OP_LDW     : begin
                alu_op      =   `ALU_OP_ADDU;
                alu_in_1    =   imm_s;
                mem_op      =   `MEM_OP_LDW;
                gpr_we_     =   `ENABLE_;
            end
            `ISA_OP_STW     : begin
                alu_op      =   `ALU_OP_ADDU;
                alu_in_1    =   imm_s;
                mem_op      =   `MEM_OP_STW;
            end
            /*System  Load Instruction*/
            `ISA_OP_TRAP    : begin
                exp_code    =   `ISA_EXP_TRAP;
            end
            /*Privileged Instruction*/
            `ISA_OP_RDCR    : begin
                if (exe_mode == `CPU_KERNEL_MODE) begin
                    alu_in_0    =   creg_rd_data;
                    gpr_we_     =   `ENABLE_;
                end else begin
                    exp_code    =   `ISA_EXP_PRV_VIO;
                end
            end
            `ISA_OP_WRCR    : begin
                if (exe_mode == `CPU_KERNEL_MODE) begin
                    ctrl_op     =   `CTRL_OP_WRCR;
                end else begin
                    exp_code    =   `ISA_EXP_PRV_VIO;
                end
            end
            `ISA_OP_EXRT    : begin
                if (exe_mode == `CPU_KERNEL_MODE) begin
                    ctrl_op     =   `CTRL_OP_EXRT;
                end else begin
                    exp_code    =   `ISA_EXP_PRV_VIO;
                end
            end
            /*other/default*/
            default         : begin
                exp_code        =   `ISA_EXP_UNDEF_INSN;
            end
        endcase
    end
    
endmodule







