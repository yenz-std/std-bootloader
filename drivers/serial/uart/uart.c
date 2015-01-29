#include <s3c2440_gpio.h>
#include <s3c2440_iomap.h>
#include <io.h>
void init_uart(void)
{
  int i = 0;
  i = readl(GPHCON);
  i = ((i & 0xff00) | 0xaa);
  writel(i,GPHCON);

  writel(0x23,ULCON0);
  writel(0x5,UCON0);
  writel(0x0,UFCON0);
  writel(0x1b,UBRDIV0);
}

char getc(void)
{ 
 
  while((readl(UTRSTAT0) & 0x1) == 0);
  return readb(URXH0);

}


void putc(char i)
{
  while((readl(UTRSTAT0) & 0x2) == 0);
  writeb(i,UTXH0);
}
