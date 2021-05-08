`ifndef __REGFILE_HEADER__  //包含文件防范
    `define __REGFILE_HEADER__
    
    /*信号电平*/
    `define HIGH    1'b1    //高电平
    `define LOW     1'b0    //低电平
    
    /*逻辑值*/
    `define ENABLE_ 1'b0    //有效(负逻辑)
    `define DISABLE_    1'b1    //有效(负逻辑)
    
    /*数据*/
    `define DATA_W  32  //数据宽度
    `define DataBus 31:0    //数据总线
    `define DATA_D  32  //数据深度
    
    /*地址*/
    `define ADDR_W  5   //地址宽度
    `define AddrBus 4:0 //地址总线
    
`endif
    