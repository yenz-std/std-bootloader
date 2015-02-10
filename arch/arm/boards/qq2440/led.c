#include <s3c2440_gpio.h>
#include <ledops.h>
#include <uart.h>
#include <nand.h> 
#include <stdio.h>


void  delay(volatile unsigned long i)
{
  do{
    i--;
  }while(i);
}

int main(void)
{
  unsigned int  i ;
  char x = 5;
  init_led();
  init_uart();
  led_on(x);
  //   nf_init();
  // nf_read(0,0x30000000,2048);

  while(1)
{
  printf("please put i: /n");
    scanf("%d",&i);
   led_on(i);
   putchar(i);
   if(x == 'x')
  led_off(6);
}
  
  /* while(1){ */
  /*   for(i = 5;i <= 8;i++){ */
  /*     led_on(i); */
  /*     delay(400000); */
  /*   } */

  /*   for(i = 5;i <= 8;i++){ */

  /*     led_off(i); */
  /*     delay(400000); */
  /*   } */
    
  /* } */
}
