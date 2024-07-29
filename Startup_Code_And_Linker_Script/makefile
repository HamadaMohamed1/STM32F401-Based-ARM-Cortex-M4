cc = arm-none-eabi-gcc 

CFLAGS = -c -mcpu=$(MACH) -std=gnu11 -mthumb -Wall	

MACH = cortex-m4

LDFLAGS = -T STM32F401RCT6_LS.ld -nostdlib -Wl,-Map=final.map

main.o: main.c
	$(cc) $(CFLAGS) $^ -o $@

GPIO.o: GPIO.c
	$(cc) $(CFLAGS) $^ -o $@

RCC.o: RCC.c
	$(cc) $(CFLAGS) $^ -o $@

SystTick.o: SystTick.c
	$(cc) $(CFLAGS) $^ -o $@
	
STM32F401RCT6StartupCode.o: STM32F401RCT6StartupCode.c
	$(cc) $(CFLAGS) $^ -o $@
	
final.elf: main.o GPIO.o RCC.o SystTick.o STM32F401RCT6StartupCode.o
	$(cc) $(LDFLAGS) $^ -o $@

All: main.o GPIO.o STM32F401RCT6StartupCode.o RCC.o SystTick.o final.elf
	
	
clean:
	rm -rf *.o *.elf
	
Load:
	openocd -f board/st_nucleo_f4.cfg