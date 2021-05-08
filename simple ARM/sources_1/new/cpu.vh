`ifndef __CPU_HEADER__
    `define __CPU_HEADER__  
    
    `define REG_NUM         32      //THE NUMBER OF REGISTERS
    `define REG_ADDR_W      5       //THE WIDTH OF REGISTER ADDRESS
    `define RegAddrBus      4:0     //THE BUS OF REGISTER ADDRESS
    
    `define CPU_IRQ_CH      8       //THE WIDTH OF IRQ  
    `define ALU_OP_W        4       //THE WIDTH OF ALU OPERATION CODE
    `define AluOpBus        3:0     //THE BUS OF ALU OPERATION CODE
    `define ALU_OP_NOP      4'h0    //NO OPERATION
    `define ALU_OP_AND      4'h1    //AND
    `define ALU_OP_OR       4'h2    //OR
    `define ALU_OP_XOR      4'h3    //XOR
    `define ALU_OP_ADDS     4'h4    //SIGNED ADD
    `define ALU_OP_ADDU     4'h5    //UNSIGNED ADD
    `define ALU_OP_SUBS     4'h6    //SIGNED SUBTRACT
    `define ALU_OP_SUBU     4'h7    //UNSIGNED SUBTRACT
    `define ALU_OP_SHRL     4'h8    //SHIFT RIGHT LOGICAL
    `define ALU_OP_SHLL     4'h9    //SHIFT LEFT LOGICAL
    `define MEM_OP_W        2       //THE WIDTH OF MEMORY OPERATION CODE
    `define MemOpBus        1:0     //THE BUS OF MEMORY OPERATION CODE
    `define MEM_OP_NOP      2'h0    //NO OPERATION
    `define MEM_OP_LDW      2'h1    //WORD READ
    `define MEM_OP_STW      2'h2    //WORD WRITE
    `define CTRL_OP_W       2       //THE WIDTH OF CONTROL OPERATIN CODE
    `define CtrlOpBus       1:0     //THE BUS OF CONTROL OPERATION CODE
    `define CTRL_OP_NOP     2'h0    //NO OPERATION
    `define CTRL_OP_WRCR    2'h1    //WRITE IN CONTROL REGISTER
    `define CTRL_OP_EXRT    2'h2    //RESTORE FROM EXCEPTION
    `define CPU_EXE_MODE_W  1       //THE WIDTH OF OPERATION/IMPLEMENTATION MODE
    `define CpuExeModeBus   0:0     //THE BUS OF OPERATION/IMPLEMENTATION MODE
    `define CPU_KERNEL_MODE 1'b0    //THE KERNEL MODE
    `define CPU_USER_MODE   1`b1    //THE USER MODE
    `define CREG_ADDR_STATUS    5'h0    //THE STATUS
    `define CREG_ADDR_PRE_STATUS    5'h1    //THE PREVIOUS STATUS
    `define CREG_ADDR_PC    5'h2    //PORGRAME COUNTER
    `define CREG_ADDR_EPC   5'h3    //EXCEPTION PROGRAME COUNTER
    `define CREG_ADDR_EXP_VECTOR    5'h4    //EXCEPTION VECTOR
    `define CREG_ADDR_CAUSE 5'h5    //EXCEPTION CAUSE REGISTER
    `define CREG_ADDR_INT_MASK  5'h6    //ASSERT MASK WORD
    `define CREG_ADDR_IRQ   5'h7    //ASSERT REQUEST
    `define CREG_ADDR_ROM_SIZE  5'h1d   //THE CAPACITY OF ROM
    `define CREG_ADDR_SPM_SIZE  5'h1e   //THE CAPACITY OF SPM
    `define CREG_ADDR_CPU_INFO  5'h1f   //THE INFORMATION/PARAMETERS OF CPU
    `define CregExeModeLoc  0       //THE LOCATION OF EXECUTIVE/IMPLEMENTATION/OPERATION MODE
    `define CregIntEnableLoc    1       //ASSERT EFFECTIVE LOCATION
    `define CregExpCodeLoc      2:0 //THE LOCATION OF EXCEPTION CODE
    `define CregDlyFlagLoc      3   //THE LOCATION OF DELAY GAB SYMBOL
    `define BusIfStateBus       1:0 //STATUS BUS
    `define BUS_IF_STATE_IDLE   2'h0    //EMPTY/SPARE/FREE
    `define BUS_IF_STATE_REQ    2'h1    //REQUEST BUS
    `define BUS_IF_STATE_ACCESS 2'h2    //ACCESS BUS
    `define BUS_IF_STATE_STALL  2'h3    //STAGANATION
    `define RESET_VECTOR        30'h0   //RESET VECTOR
    `define ShAmountBus         4:0     //SHIFT AMOUNT OF BUS
    `define ShAmountLoc         4:0     //SHIFT AMOUNT LOCATION
    `define RELEASE_YEAR       8'd41    //PRODUCTION YEAR(YYYY-1970)
    `define RELEASE_MONTH      8'd7     //PRODUCTION MONTH
    `define RELEASE_VERSION     8'd1    //VERSION
    `define RELEASE_REVISION    8'd0    //REVISION
    
    
    
`endif