#ifndef _LED_OPS_H
#define _LED_OPS_H
#include <bitops.h>
#include <s3c2440_gpio.h>
#include <io.h>

/* #define led_off(nr) __set_bit(nr,(volatile void *)GPBDAT) */
/* #define led_on(nr)  __clear_bit(nr,(volatile void *)GPBDAT) */

void led_off(int nr)
 {
   unsigned  int *i = 0;
   *i = (unsigned int)readl(GPBDAT);
   __set_bit(nr,i);
   writel(*i,GPBDAT);
 }

void led_on(int nr)
 {
   unsigned int *i = 0;
  *i = (unsigned int)readl(GPBDAT);
   __clear_bit(nr,i);
   writel(*i,GPBDAT);
 }

void init_led(void)
{
   unsigned int date = readl(GPBCON);

   date = (date & (~0x3fc00)) | 0x15400 ;
   writel(date,GPBCON);

   int i ;
   for(i = 5; i <= 8; i++){
     led_off(i);
  }
}

#endif
