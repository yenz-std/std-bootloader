#include <s3c2440_gpio.h>
#include <ledops.h>
#include <uart.h>

void  delay(volatile unsigned long i)
{
  do{
    i--;
  }while(i);
}

int main(void)
{
  unsigned int  i ;
  char x = '5';
  init_led();
  init_uart();
  led_on(x);
  while(1)
{
   x = getchar();
   led_on(6);
   putchar(x);
   if(x==6)
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
