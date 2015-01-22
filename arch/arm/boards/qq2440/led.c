#include <s3c2440_gpio.h>
#include <ledops.h>

void delay(void)
{
  int i = 40000;
  do{
    i--;
  }while(i);
}

int main(void)
{
  int i ;

  init_led();

  while(1){
    for(i = 5;i <= 8;i++){
      led_on(i);
      delay();
    }

    for(i = 5;i <= 8;i++){

      led_off(i);
      delay();
    }
    
  }
}
