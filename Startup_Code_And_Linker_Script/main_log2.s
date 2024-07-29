
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
  54:	40023800 	andmi	r3, r2, r0, lsl #16
  58:	05fa0500 	ldrbeq	r0, [sl, #1280]!	@ 0x500
  5c:	00000000 	andeq	r0, r0, r0

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

Disassembly of section .data:

00000000 <PC13>:
   0:	01010d02 	tsteq	r1, r2, lsl #26
   4:	Address 0x4 is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	43434700 	movtmi	r4, #14080	@ 0x3700
   4:	4128203a 			@ <UNDEFINED> instruction: 0x4128203a
   8:	47206d72 			@ <UNDEFINED> instruction: 0x47206d72
   c:	5420554e 	strtpl	r5, [r0], #-1358	@ 0xfffffab2
  10:	636c6f6f 	cmnvs	ip, #444	@ 0x1bc
  14:	6e696168 	powvsez	f6, f1, #0.0
  18:	2e333120 	rsfcssp	f3, f3, f0
  1c:	65522e33 	ldrbvs	r2, [r2, #-3635]	@ 0xfffff1cd
  20:	2820316c 	stmdacs	r0!, {r2, r3, r5, r6, r8, ip, sp}
  24:	6c697542 	cfstr64vs	mvdx7, [r9], #-264	@ 0xfffffef8
  28:	72612064 	rsbvc	r2, r1, #100	@ 0x64
  2c:	33312d6d 	teqcc	r1, #6976	@ 0x1b40
  30:	2934322e 	ldmdbcs	r4!, {r1, r2, r3, r5, r9, ip, sp}
  34:	33312029 	teqcc	r1, #41	@ 0x29
  38:	312e332e 			@ <UNDEFINED> instruction: 0x312e332e
  3c:	32303220 	eorscc	r3, r0, #32, 4
  40:	31363034 	teqcc	r6, r4, lsr r0
  44:	Address 0x44 is out of bounds.


Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002d41 	andeq	r2, r0, r1, asr #26
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000023 	andeq	r0, r0, r3, lsr #32
  10:	2d453705 	stclcs	7, cr3, [r5, #-20]	@ 0xffffffec
  14:	0d06004d 	stceq	0, cr0, [r6, #-308]	@ 0xfffffecc
  18:	02094d07 	andeq	r4, r9, #448	@ 0x1c0
  1c:	01140412 	tsteq	r4, r2, lsl r4
  20:	03170115 	tsteq	r7, #1073741829	@ 0x40000005
  24:	01190118 	tsteq	r9, r8, lsl r1
  28:	061e011a 			@ <UNDEFINED> instruction: 0x061e011a
  2c:	Address 0x2c is out of bounds.

