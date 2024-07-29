
main.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <main>:
   0:	b580      	push	{r7, lr}
   2:	af00      	add	r7, sp, #0
   4:	f7ff fffe 	bl	60 <SystemClock_Config>
   8:	f7ff fffe 	bl	0 <Systick_init>
   c:	4b11      	ldr	r3, [pc, #68]	@ (54 <main+0x54>)
   e:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
  10:	4a10      	ldr	r2, [pc, #64]	@ (54 <main+0x54>)
  12:	f043 0301 	orr.w	r3, r3, #1
  16:	6313      	str	r3, [r2, #48]	@ 0x30
  18:	4b0e      	ldr	r3, [pc, #56]	@ (54 <main+0x54>)
  1a:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
  1c:	4a0d      	ldr	r2, [pc, #52]	@ (54 <main+0x54>)
  1e:	f043 0304 	orr.w	r3, r3, #4
  22:	6313      	str	r3, [r2, #48]	@ 0x30
  24:	4b0b      	ldr	r3, [pc, #44]	@ (54 <main+0x54>)
  26:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
  28:	4a0a      	ldr	r2, [pc, #40]	@ (54 <main+0x54>)
  2a:	f043 0302 	orr.w	r3, r3, #2
  2e:	6313      	str	r3, [r2, #48]	@ 0x30
  30:	4809      	ldr	r0, [pc, #36]	@ (58 <main+0x58>)
  32:	f7ff fffe 	bl	0 <scb_set_priority_group>
  36:	4809      	ldr	r0, [pc, #36]	@ (5c <main+0x5c>)
  38:	f7ff fffe 	bl	0 <GPIO_Pin_init>
  3c:	f383 8808 	msr	MSP, r3
  40:	210d      	movs	r1, #13
  42:	2002      	movs	r0, #2
  44:	f7ff fffe 	bl	0 <GPIO_Toggle_Pin_Value>
  48:	f44f 70fa 	mov.w	r0, #500	@ 0x1f4
  4c:	f7ff fffe 	bl	0 <delay_ms>
  50:	e7f6      	b.n	40 <main+0x40>
  52:	bf00      	nop
  54:	40023800 	.word	0x40023800
  58:	05fa0500 	.word	0x05fa0500
  5c:	00000000 	.word	0x00000000

00000060 <SystemClock_Config>:
  60:	b580      	push	{r7, lr}
  62:	b08a      	sub	sp, #40	@ 0x28
  64:	af00      	add	r7, sp, #0
  66:	2300      	movs	r3, #0
  68:	f887 3027 	strb.w	r3, [r7, #39]	@ 0x27
  6c:	f107 0310 	add.w	r3, r7, #16
  70:	2200      	movs	r2, #0
  72:	601a      	str	r2, [r3, #0]
  74:	605a      	str	r2, [r3, #4]
  76:	609a      	str	r2, [r3, #8]
  78:	60da      	str	r2, [r3, #12]
  7a:	611a      	str	r2, [r3, #16]
  7c:	1d3b      	adds	r3, r7, #4
  7e:	2200      	movs	r2, #0
  80:	601a      	str	r2, [r3, #0]
  82:	605a      	str	r2, [r3, #4]
  84:	609a      	str	r2, [r3, #8]
  86:	2301      	movs	r3, #1
  88:	613b      	str	r3, [r7, #16]
  8a:	2301      	movs	r3, #1
  8c:	617b      	str	r3, [r7, #20]
  8e:	f107 0310 	add.w	r3, r7, #16
  92:	4618      	mov	r0, r3
  94:	f7ff fffe 	bl	0 <HALL_RCC_OscConfig>
  98:	4603      	mov	r3, r0
  9a:	f887 3027 	strb.w	r3, [r7, #39]	@ 0x27
  9e:	2300      	movs	r3, #0
  a0:	607b      	str	r3, [r7, #4]
  a2:	2300      	movs	r3, #0
  a4:	60bb      	str	r3, [r7, #8]
  a6:	2300      	movs	r3, #0
  a8:	60fb      	str	r3, [r7, #12]
  aa:	1d3b      	adds	r3, r7, #4
  ac:	4618      	mov	r0, r3
  ae:	f7ff fffe 	bl	0 <HALL_RCC_ClockConfig>
  b2:	4603      	mov	r3, r0
  b4:	f887 3027 	strb.w	r3, [r7, #39]	@ 0x27
  b8:	f897 3027 	ldrb.w	r3, [r7, #39]	@ 0x27
  bc:	4618      	mov	r0, r3
  be:	3728      	adds	r7, #40	@ 0x28
  c0:	46bd      	mov	sp, r7
  c2:	bd80      	pop	{r7, pc}
