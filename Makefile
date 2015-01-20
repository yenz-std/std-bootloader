
HOSTNAME	= $(shell uname -n)

ifeq ("$HOSTNAME","yenz_homepc" )
    CROSS_COMPILE := arm-none-eabi-
else
    CROSS_COMPILE := arm-linux-guneabif-
endif

#cross_compile tools

AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
CC	= $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP	= $(CROSS_COMPILE)objdump

CFLAGS	= -Wall -Wundef -Wstrict-prototypes -Wno-gtrigraphs -Werror-implicit-function-declartion -fno-strict-aliasing -fno-common -Os -pipe -g
 


led.bin : start.o led.o
	arm-linux-gnueabihf-ld -g -o led.elf -Ttext 0 start.o led.o
	arm-linux-gnueabihf-objcopy -O binary  led.elf led.bin
	arm-linux-gnueabihf-objdump -D  led.elf > start.dis

%.o : %.S
	arm-linux-gnueabihf-gcc -march=armv4t -msoft-float -marm -W -g -c $^ -o $@
%.o : %.c
	arm-linux-gnueabihf-gcc -march=armv4t -msoft-float -marm -W -g -c $^ -o $@



clean :
	-rm start.o led.o led.bin  start.dis  led.elf *~
