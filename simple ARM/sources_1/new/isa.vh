`ifndef __ISA_HEADER__
    `define __ISA_HEADER__ 
    
    `define ISA_NOP         32'h0       //NO OPERATION
    `define ISA_OP_W        6           //THE WIDTH OF OPERATION CODE
    `define IsaOpBus        5:0         //THE OPERATION CODE BUS
    `define IsaOpLoc        31:26       //THE LOCATION OF OPERATION CODE
    
    `define ISA_OP_ANDR     6'h00       //THE LOGIC AND OF REGISTERS
    `define ISA_OP_ANDI     6'h01       //THE LOGIC AND OF REGISTER AND CONSTANT
    `define ISA_OP_ORR      6'h02       //THE LOGIC OR OF REGISTERS
    `define ISA_OP_ORI      6'h03       //THE LOGIC OR OF REGISTER AND CONSTANT
    `define ISA_OP_XORR     6'h04       //THE LOGIC EXCLUSIVE OR OF REGISTERS
    `define ISA_OP_XORI     6'h05       //THE LOGIC EXCLUSIVE OR OF REGISTER AND CONSTANT
    
    `define ISA_OP_ADDSR    6'h06       //THE SIGNED ADD OF REGISTERS
    `define ISA_OP_ADDSI    6'h07       //THE SIGNED ADD OF REGISTER AND CONSTANT
    `define ISA_OP_ADDUR    6'h08       //THE UNSIGNED ADD OF REGISTERS
    `define ISA_OP_ADDUI    6'h09       //THE UNSIGNED ADD OF REGISTER AMD CONSTANT
    `define ISA_OP_SUBSR    6'h0a       //THE SIGNED SUBTRACTION OF REGISTERS
    `define ISA_OP_SUBUR    6'h0b       //THE UNSIGNED SUBTRACTION OF REGISTERS
    
    `define ISA_OP_SHRLR    6'h0c       //THE LOGIC RIGHT SHIFT OF REGISTERS
    `define ISA_OP_SHRLI    6'h0d       //THE LOGIC RIGHT SHIFT OF REGISTER AND CONSTANT
    `define ISA_OP_SHLLR    6'h0e       //THE LOGIC LEFT SHIFT OF REGISTERS
    `define ISA_OP_SHLLI    6'h0f       //THE LOGIC LEFT SHIFT OF REGISTER AND CONSTANT
    `define ISA_OP_BE       6'h10       //THE COMPARATION OF REGISTERS(==)
    `define ISA_OP_BNE      6'h11       //THE COMPARATION OF REGISTERS(!=)
    `define ISA_OP_BSGT     6'h12       //THE SIGNED COMPARATION OF REGISTERS(<)
    `define ISA_OP_BUGT     6'h13       //THE UNSIGNED COMPARATION OF REGISTERS(<)
    `define ISA_OP_JMP      6'h14       //THE SPECIFIC ABSOLUTE BRANCH OF REGISTERS
    `define ISA_OP_CALL     6'h15       //THE REGISTER-SPECIFIC SUBPROGRAME CALL
    `define ISA_OP_LDW      6'h16       //THE WORD READ
    `define ISA_OP_STW      6'h17       //THE WORD WRITE
    `define ISA_OP_TRAP     6'h18       //THE TRAP
    `define ISA_OP_RDCR     6'h19       //THE REGISTER OF READ CONTROL
    `define ISA_OP_WRCR     6'h1a       //THE REGISTER OF WRITE CONTROL
    `define ISA_OP_EXRT     6'h1b       //THE REGISTER OF  EXCEPTION RESTORE
    `define ISA_REG_ADDR_W  5           //THE WIDTH OF REGISTER ADDRESS
    `define IsaRegAddrBus   4:0         //THE WIDTH OF REGISTERS ADDRESS
    `define IsaRaAddrLoc    25:21       //THE LOCATION OF REGISTER RA
    `define IsaRbAddrLoc    20:16       //THE LOCATION OF REGISTER RB
    `define IsaRcAddrLoc    15:11       //THE LOCATION OF REGISTER RC
    `define ISA_IMM_W       16          //THE WIDTH OF IMMEDIATE
    `define ISA_EXT_W       16          //THE WIDTH OF EXCEPTION
    `define ISA_IMM_MSB     15          //THE HIGHEST LEVEL OF IMMEDIATE
    `define IsaImmBus       15:0        //THE BUS OF IMMEDIATE
    `define IsaImmLoc       15:0        //THE LOCATION OF IMMEDIATE
    `define ISA_EXP_W       3           //THE WIDTH OF EXCEPTION CODE
    `define IsaExpBus       2:0         //THE BUS OF EXCEPTION CODE
    `define ISA_EXP_NO_EXP      3'h0        //NO EXCEPTION
    `define ISA_EXP_EXT_INT     3'h1        //OUTWARD ASSERT
    `define ISA_EXP_UNDEF_INSN  3'h2        //UNDEFINED INSTRUCTION
    `define ISA_EXP_OVERFLOW    3'h3        //OVERFLOW
    `define ISA_EXP_MISS_ALIGN  3'h4        //ADDRESS WITHOUT ALIGNMENT
    `define ISA_EXP_TRAP    3'h4        //TRAP
    `define ISA_EXP_PRV_VIO 3'h6        //VIOLATION OF PRIVILEGE
`endif