#include <s3c2440_gpio.h>
#include <s3c2440_iomap.h>
#include <io.h>
void init_uart(void)
{
  int i = 0;
  i = readl(GPHCON);
  i = ((i & 0xff00) | 0xaa);
  writel(i,GPHCON);

  writel(0x3,ULCON0);
  writel(0x5,UCON0);
  writel(0x0,UFCON0);
  writew(27,UBRDIV0);
}

char getchar(void)
{ 
  //  while(((readl(UFSTAT0) & (1<<6)) == 0) && ((readl(UFSTAT0) & 0x3f) == 0));
   while((readl(UTRSTAT0) & 0x1) == 0);
  return readb(URXH0);

}


void putchar(char i)
{
  // while((readl(UFSTAT0) & (1<<14)) == 1);
  while((readl(UTRSTAT0) & 0x2) == 0);
  writeb(i,UTXH0);
}
