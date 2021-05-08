`ifndef __GLOBAL_CONFIG_HEADER__  //°üº¬ÎÄ¼þ·À·¶
    `define __GLOBAL_CONFIG_HEADER__
    
    `define POSITIVE_RESET      NaN     //when use active high to reset defines positive reset
    `define NEGATIVE_RESET      NaN     //wher use active low to reset defines negative reset
    
    `define POSITIVE_MEMORY     NaN     //when use active high to reset defines positive memory
    `define NEGATIVE_MEMORY     NaN     //when use active low to reset defines negative memory
    
    `define IMPLEMENT_TIMER     NaN     //need to implement clock defines implement timer
    `define IMPLEMENT_UART      NaN     //need to implement uart defines implement uart
    `define IMPLEMENT_GPIO      NaN     //need to implement general I/O defines implement gpio
    
//    `define RESET_EDGE          posedge //reset signal edge
    `define RESET_EDGE          negedge //reset signal edge
    
//    `define RESET_ENABLE        1'b1    //reset enable(positive)
    `define RESET_ENABLE        1'b0    //reset enable(negative)
    
//    `define RESET_DISABLE       1'b0    //reset disable
    `define RESET_DISABLE       1'b1    //reset disable
    
//    `define MEM_ENABLE          1'b1    //memory enable(positive)
    `define MEM_ENABLE          1'b0    //memory enable(negative)
    
//    `define MEM_DISABLE         1'b0    //memory disable
    `define MEM_DISABLE         1'b1    //memory disable
    
    
`endif