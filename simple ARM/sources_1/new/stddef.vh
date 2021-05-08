`ifndef __STDDEF_HEADER__  //°üº¬ÎÄ¼þ·À·¶
    `define __STDDEF_HEADER__
    
    `define HIGH        1'b1        //high level signal
    `define LOW         1'b0        //low level signal
    `define DISABLE     1'b0        //disable(postive logic)
    `define ENABLE      1'b1        //enable(positive logic)
    `define DISABLE_    1'b1        //disable(negative logic)
    `define ENABLE_     1'b0        //enable(negative logic)
    
    `define READ        1'b1        //read signal
    `define WRITE       1'b0        //write signal
    
    `define LSB         0           //the lowest rank
    `define BYTE_DATA_W 8           //data width(bytes)
    `define BYTE_MSB    7           //the highest rank(bytes)
    `define ByteDataBus 7:0         //the data bus(bytes)
    
    `define WORD_DATA_W 32          //the data witdth(word)
    `define WORD_MSB    31          //the higheset rank(word)
    `define WordDataBus 31:0        //the data bus(word)
    
    `define WORD_ADDR_W 30          //the width of address
    `define WORD_ADDR_MSB 29        //the highest rank
    `define WordAddrBus 29:0        //address bus
    
    `define BYTE_OFFSET_W   2       //the offset width
    `define ByteOffsetBus   1:0     //the offset bus
    `define WordAddrLoc     31:2    //the byte address location
    `define ByteOffsetLoc   1:0     //the byte offset address
    `define BYTE_OFFSET_WORD    2'b00   //the border of word
    
    
`endif