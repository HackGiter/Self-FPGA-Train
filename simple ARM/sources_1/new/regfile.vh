`ifndef __REGFILE_HEADER__  //�����ļ�����
    `define __REGFILE_HEADER__
    
    /*�źŵ�ƽ*/
    `define HIGH    1'b1    //�ߵ�ƽ
    `define LOW     1'b0    //�͵�ƽ
    
    /*�߼�ֵ*/
    `define ENABLE_ 1'b0    //��Ч(���߼�)
    `define DISABLE_    1'b1    //��Ч(���߼�)
    
    /*����*/
    `define DATA_W  32  //���ݿ��
    `define DataBus 31:0    //��������
    `define DATA_D  32  //�������
    
    /*��ַ*/
    `define ADDR_W  5   //��ַ���
    `define AddrBus 4:0 //��ַ����
    
`endif
    