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
