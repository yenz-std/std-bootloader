DEBUG := y

HOSTNAME	= $(shell uname -n)

ifeq ("$HOSTNAME","yenz_homepc" )
    CROSS_COMPILE := arm-none-eabi-
else
    CROSS_COMPILE := arm-linux-gnueabihf-
endif

#cross_compile tools

AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
CC	= $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP	= $(CROSS_COMPILE)objdump

CFLAGS	= -Wall -Wundef -Wstrict-prototypes -Wno-gtrigraphs -fno-strict-aliasing -fno-common -Os -pipe 
 ifeq ("$DEBUG","y")
	CFLAGS += -g
endif

export AS LD CC OBJCOPY OBJDUMP
export CFLAGS LDFLAGS AFLAGS

rootdir := $(shell pwd)
srctree = $(rootdir)
objs := led.o
export srctree  objs

VPATH := $(srctree) : $(srctree)/arch/arm/boards/qq2440 : $(srctree)/arch/arm/cpu/s3c2440/ $(srctree)/arch/arm/cpu/s3c2440/include

apath = $(srctree)/include $(srctree)/arch/arm/boards/qq2440/include $(srctree)/arch/arm/cpu/s3c2440/include
id := $(srctree)/arch/arm/cpu/s3c2440/include
id2 := $(srctree)/arch/arm/boards/qq2440/include
id3 := $(srctree)/include

include $(srctree)/arch/arm/Makefile
 
.PHONY := all
all : $(objs)
	echo "The objs is $(objs)"
	echo "The srctree is $(srctree)"
	echo "The VPATH is $(VPATH)"
	echo "the $$^ is $^"
	$(CC) $(LDFLAGS) -Ttext 0 -o bootm $^

led.bin : $(objs)  
	arm-linux-gnueabihf-ld -g -o led.elf -Ttext 0 $^
	arm-linux-gnueabihf-objcopy -O binary  led.elf led.bin
	arm-linux-gnueabihf-objdump -D  led.elf > start.dis

%.o : %.c
	$(CC) $(CFLAGS) -I$(id) -I$(id2) -I$(id3) -march=armv4t -msoft-float -marm -o $@ $< -c



%.o : %.S
	$(CC) $(CFLAGS) -I$(id) -I$(id2) -I$(id3) -march=armv4t -msoft-float -marm -o $@ $< -c






clean :
	-rm *.o *.bin  *.dis  *.elf *~
