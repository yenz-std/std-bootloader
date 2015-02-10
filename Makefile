DEBUG := y

HOSTNAME   = $(shell uname -n)


ifeq ("$(HOSTNAME)","yenz_homepc")

    CROSS_COMPILE := arm-linux-gnueabihf-
else
    CROSS_COMPILE := arm-linux-gnueabihf-
endif

#cross_compile tools

AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
CC	= $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP	= $(CROSS_COMPILE)objdump

CFLAGS	= -Wall -Wundef -Wstrict-prototypes -fno-strict-aliasing -fno-common -Os -pipe -fno-builtin
 
 ifeq ("$(DEBUG)","y")
	CFLAGS += -g
endif

export AS LD CC OBJCOPY OBJDUMP
export CFLAGS LDFLAGS AFLAGS
srctree := $(shell pwd)
export srctree  objs objs_libc

VPATH := $(srctree) : $(srctree)/arch/arm/boards/qq2440 : $(srctree)/arch/arm/cpu/s3c2440/ : $(srctree)/drivers/serial/uart/:$(srctree)/drivers/nand/:$(srctree)/lib/


id1  := $(srctree)/arch/arm/cpu/s3c2440/include
id2 := $(srctree)/arch/arm/boards/qq2440/include
id3 := $(srctree)/include
id  := -I$(id1) -I$(id2) -I$(id3)

include $(srctree)/arch/arm/Makefile
include $(srctree)/drivers/serial/uart/Makefile
include $(srctree)/drivers/nand/Makefile
include $(srctree)/lib/Makefile

LDFLAGS := -g -T $(srctree)/arch/arm/boards/qq2440/qq2440.lds
.PHONY := all
all : $(objs) libc.a
	$(LD) $(LDFLAGS) -o bootm  $^
	$(OBJCOPY) -O binary bootm led.bin
	$(OBJDUMP) -D bootm > led.dis

libc.a: $(objs_libc)
	${AR} -r -o $@ $^

clean_libc:
	rm -f libc.a *.o		



NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

%.o : %.c
	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(id) -fpic -march=armv4t -msoft-float -marm -o $@ $< -c

%.o : %.S
	$(CC) $(CFLAGS)  $(NOSTDINC_FLAGS) $(id) -fpic -march=armv4t -msoft-float -marm -o $@ $< -c


clean :
	@ -rm *.o *.bin  *.dis  *.elf *~ bootm \#*\#
