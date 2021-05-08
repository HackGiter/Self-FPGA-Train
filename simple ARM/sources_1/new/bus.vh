`ifndef __BUS_HEADER__  //°üº¬ÎÄ¼þ·À·¶
    `define __BUS_HEADER__
    
    /*Bus master*/
    `define BUS_MASTER_CH       4       //bus master channels
    `define BUS_MASTER_INDEX_W  2       //bus master index width
    
    `define BusOwnerBus         1:0     //bus ownership status bus
    `define BUS_OWNER_MASTER_0  2'h0    //bus owners: number 0 bus master
    `define BUS_OWNER_MASTER_1  2'h1    //bus owners: number 1 bus master
    `define BUS_OWNER_MASTER_2  2'h2    //bus owners: number 2 bus master
    `define BUS_OWNER_MASTER_3  2'h3    //bus owners: number 3 bus master
    
    `define BUS_SLAVE_CH        8       //bus slave channels
    `define BUS_SLAVE_INDEX_W   3       //bus slave index width
    `define BusSlaveIndexBus    2:0     //bus slave index bus
    `define BusSlaveIndexLoc    29:27   //bus slave index location
    `define BUS_SLAVE_0         0       //bus slave: number 0
    `define BUS_SLAVE_1         1       //bus slave: number 1
    `define BUS_SLAVE_2         2       //bus slave: number 2
    `define BUS_SLAVE_3         3       //bus slave: number 3
    `define BUS_SLAVE_4         4       //bus slave: number 4
    `define BUS_SLAVE_5         5       //bus slave: number 5
    `define BUS_SLAVE_6         6       //bus slave: number 6
    `define BUS_SLAVE_7         7       //bus slave: number 7

    
`endif