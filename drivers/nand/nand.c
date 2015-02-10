#include <s3c2440_iomap.h>
#include <io.h>
#include <init.h>

#define NFCONT_nFCE    (1 << 1)
#define NFCONT_EN      (1)
#define NFCONT_INITECC (1 << 4)
#define NFSTAT_BUSY    (1)
#define NFCONF_TIME   ((1 << 4) | (3 << 8) | (1 << 12))

#define NF_CMD_RESET   0xff
#define NF_CMD_READ1_1ST 0x0
#define NF_CMD_READ1_2ND 0x1
#define NF_CMD_READ2     0x50
#define NF_CMD_READ_ID   0x90
#define NF_CMD_ERASE     0x60
#define NF_CMD_READ_STATUS 0x70
#define NF_CMD_PROGRAM    0x80

static void __bootm_init enable_cs(void)
{
  writew(readw(NFCONT) & ~(NFCONT_nFCE),NFCONT);
}

static void __bootm_init  disable_cs(void)
{
  writew(readw(NFCONT) | NFCONT_nFCE, NFCONT);
}

static void __bootm_init enable_nand_controller(void)
{
  
  writew(readw(NFCONT) | NFCONT_EN, NFCONT);

}

static void __bootm_init disable_nand_controller(void)
{
  writew(readw(NFCONT) & ~(NFCONT_EN), NFCONT);
}

static void __bootm_init send_cmd(unsigned char cmd)
{
  writeb(cmd, NFCMMD);
}

static void __bootm_init send_addr(unsigned char addr)
{
  writeb(addr,NFADDR);
}

static char __bootm_init read_data(void)
{
  return readb(NFDATA);
}
static void __bootm_init wait_for_completion(void)
{

  while(!(readw(NFSTAT) & NFSTAT_BUSY))
    ;
}

static void __bootm_init reset_nand(void)
{
  enable_cs();
  send_cmd(NF_CMD_RESET);
  wait_for_completion();
  disable_cs();
}

void __bootm_init nf_init(void)
{
  writew(readw(NFCONF) | NFCONF_TIME, NFCONF);
  enable_nand_controller();
  reset_nand();
}

static void __bootm_init nand_send_addr(unsigned int addr)
{

  send_addr(addr & 0xff);
  send_addr((addr >> 9) & 0xff );
  send_addr((addr >> 17) & 0xff);
  send_addr((addr >> 25) & 0xff);
 
}



void __bootm_init nf_read(unsigned int src_addr, unsigned int desc_addr, unsigned int size)
{
  int i = 0;
 
  int count = 0;
  unsigned int addr = src_addr;

 
 /* unsigned int column_addr = src_addr % 512; */
 /*  unsigned int page_addr = (src_addr >> 9); */
   unsigned char * buf = (unsigned char *)desc_addr; 

 /*    send_addr(column_addr & 0xff); */
 /*    send_addr(page_addr & 0xff); */
 /*    send_addr((page_addr >> 8) & 0xff); */
 /*    send_addr((page_addr >> 16) & 0xff); */
   while(count < size) {

    /* if(column_addr < 255)  */
    /*   send_cmd(NF_CMD_READ1_1ST);else */
    /*   send_cmd(NF_CMD_READ1_2ND); */
     reset_nand();
     enable_cs();

     send_cmd(NF_CMD_READ1_1ST);
     nand_send_addr(addr);
   
    wait_for_completion();
    for(; ((i < 512) && (count < size)); i++){
      
      *buf = read_data();
       buf++;
       addr++;
       count++;
    }
   i = 0;
     //  column_addr = 0;		
   disable_cs(); 

  }

}
