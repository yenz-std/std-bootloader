DEBUG := y

HOSTNAME	= $(shell uname -n)

ifeq ("$(HOSTNAME)","yenz_homepc" )
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
 
 ifeq ("$(DEBUG)","y")
	CFLAGS += -g
endif

export AS LD CC OBJCOPY OBJDUMP
export CFLAGS LDFLAGS AFLAGS
srctree := $(shell pwd)
export srctree  objs

VPATH := $(srctree) : $(srctree)/arch/arm/boards/qq2440 : $(srctree)/arch/arm/cpu/s3c2440/ 


id1  := $(srctree)/arch/arm/cpu/s3c2440/include
id2 := $(srctree)/arch/arm/boards/qq2440/include
id3 := $(srctree)/include
id  := -I$(id1) -I$(id2) -I$(id3)

include $(srctree)/arch/arm/Makefile
LDFLAGS := -g -T $(srctree)/arch/arm/boards/qq2440/qq2440.lds
.PHONY := all
all : $(objs)
	$(LD) $(LDFLAGS) -o bootm  $^
	$(OBJCOPY) -O binary bootm led.bin
	$(OBJDUMP) -D bootm > led.dis
led.bin : $(objs)  
	arm-linux-gnueabihf-ld -g -o led.elf -Ttext 0 $^
	arm-linux-gnueabihf-objcopy -O binary  led.elf led.bin
	arm-linux-gnueabihf-objdump -D  led.elf > start.dis


NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

%.o : %.c
	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(id) -march=armv4t -msoft-float -marm -o $@ $< -c

%.o : %.S
	$(CC) $(CFLAGS)  $(NOSTDINC_FLAGS) $(id) -march=armv4t -msoft-float -marm -o $@ $< -c


clean :
	@ -rm *.o *.bin  *.dis  *.elf *~
