
GPIO.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <GPIO_Pin_init>:
   0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
   4:	e28db000 	add	fp, sp, #0
   8:	e24dd014 	sub	sp, sp, #20
   c:	e50b0010 	str	r0, [fp, #-16]
  10:	e3a03000 	mov	r3, #0
  14:	e54b3005 	strb	r3, [fp, #-5]
  18:	e51b3010 	ldr	r3, [fp, #-16]
  1c:	e3530000 	cmp	r3, #0
  20:	1a000002 	bne	30 <GPIO_Pin_init+0x30>
  24:	e3a03001 	mov	r3, #1
  28:	e54b3005 	strb	r3, [fp, #-5]
  2c:	ea0000e5 	b	3c8 <GPIO_Pin_init+0x3c8>
  30:	e51b3010 	ldr	r3, [fp, #-16]
  34:	e5d33000 	ldrb	r3, [r3]
  38:	e1a02003 	mov	r2, r3
  3c:	e59f3398 	ldr	r3, [pc, #920]	@ 3dc <GPIO_Pin_init+0x3dc>
  40:	e7933102 	ldr	r3, [r3, r2, lsl #2]
  44:	e5932000 	ldr	r2, [r3]
  48:	e51b3010 	ldr	r3, [fp, #-16]
  4c:	e5d33001 	ldrb	r3, [r3, #1]
  50:	e1a03083 	lsl	r3, r3, #1
  54:	e3a01003 	mov	r1, #3
  58:	e1a03311 	lsl	r3, r1, r3
  5c:	e1e03003 	mvn	r3, r3
  60:	e1a01003 	mov	r1, r3
  64:	e51b3010 	ldr	r3, [fp, #-16]
  68:	e5d33000 	ldrb	r3, [r3]
  6c:	e1a00003 	mov	r0, r3
  70:	e59f3364 	ldr	r3, [pc, #868]	@ 3dc <GPIO_Pin_init+0x3dc>
  74:	e7933100 	ldr	r3, [r3, r0, lsl #2]
  78:	e0022001 	and	r2, r2, r1
  7c:	e5832000 	str	r2, [r3]
  80:	e51b3010 	ldr	r3, [fp, #-16]
  84:	e5d33000 	ldrb	r3, [r3]
  88:	e1a02003 	mov	r2, r3
  8c:	e59f3348 	ldr	r3, [pc, #840]	@ 3dc <GPIO_Pin_init+0x3dc>
  90:	e7933102 	ldr	r3, [r3, r2, lsl #2]
  94:	e5932000 	ldr	r2, [r3]
  98:	e51b3010 	ldr	r3, [fp, #-16]
  9c:	e5d33002 	ldrb	r3, [r3, #2]
  a0:	e1a01003 	mov	r1, r3
  a4:	e51b3010 	ldr	r3, [fp, #-16]
  a8:	e5d33001 	ldrb	r3, [r3, #1]
  ac:	e1a03083 	lsl	r3, r3, #1
  b0:	e1a03311 	lsl	r3, r1, r3
  b4:	e1a01003 	mov	r1, r3
  b8:	e51b3010 	ldr	r3, [fp, #-16]
  bc:	e5d33000 	ldrb	r3, [r3]
  c0:	e1a00003 	mov	r0, r3
  c4:	e59f3310 	ldr	r3, [pc, #784]	@ 3dc <GPIO_Pin_init+0x3dc>
  c8:	e7933100 	ldr	r3, [r3, r0, lsl #2]
  cc:	e1822001 	orr	r2, r2, r1
  d0:	e5832000 	str	r2, [r3]
  d4:	e51b3010 	ldr	r3, [fp, #-16]
  d8:	e5d33000 	ldrb	r3, [r3]
  dc:	e1a02003 	mov	r2, r3
  e0:	e59f32f4 	ldr	r3, [pc, #756]	@ 3dc <GPIO_Pin_init+0x3dc>
  e4:	e7933102 	ldr	r3, [r3, r2, lsl #2]
  e8:	e593200c 	ldr	r2, [r3, #12]
  ec:	e51b3010 	ldr	r3, [fp, #-16]
  f0:	e5d33001 	ldrb	r3, [r3, #1]
  f4:	e1a03083 	lsl	r3, r3, #1
  f8:	e3a01003 	mov	r1, #3
  fc:	e1a03311 	lsl	r3, r1, r3
 100:	e1e03003 	mvn	r3, r3
 104:	e1a01003 	mov	r1, r3
 108:	e51b3010 	ldr	r3, [fp, #-16]
 10c:	e5d33000 	ldrb	r3, [r3]
 110:	e1a00003 	mov	r0, r3
 114:	e59f32c0 	ldr	r3, [pc, #704]	@ 3dc <GPIO_Pin_init+0x3dc>
 118:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 11c:	e0022001 	and	r2, r2, r1
 120:	e583200c 	str	r2, [r3, #12]
 124:	e51b3010 	ldr	r3, [fp, #-16]
 128:	e5d33000 	ldrb	r3, [r3]
 12c:	e1a02003 	mov	r2, r3
 130:	e59f32a4 	ldr	r3, [pc, #676]	@ 3dc <GPIO_Pin_init+0x3dc>
 134:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 138:	e593200c 	ldr	r2, [r3, #12]
 13c:	e51b3010 	ldr	r3, [fp, #-16]
 140:	e5d33005 	ldrb	r3, [r3, #5]
 144:	e1a01003 	mov	r1, r3
 148:	e51b3010 	ldr	r3, [fp, #-16]
 14c:	e5d33001 	ldrb	r3, [r3, #1]
 150:	e1a03083 	lsl	r3, r3, #1
 154:	e1a03311 	lsl	r3, r1, r3
 158:	e1a01003 	mov	r1, r3
 15c:	e51b3010 	ldr	r3, [fp, #-16]
 160:	e5d33000 	ldrb	r3, [r3]
 164:	e1a00003 	mov	r0, r3
 168:	e59f326c 	ldr	r3, [pc, #620]	@ 3dc <GPIO_Pin_init+0x3dc>
 16c:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 170:	e1822001 	orr	r2, r2, r1
 174:	e583200c 	str	r2, [r3, #12]
 178:	e51b3010 	ldr	r3, [fp, #-16]
 17c:	e5d33002 	ldrb	r3, [r3, #2]
 180:	e3530001 	cmp	r3, #1
 184:	0a000003 	beq	198 <GPIO_Pin_init+0x198>
 188:	e51b3010 	ldr	r3, [fp, #-16]
 18c:	e5d33002 	ldrb	r3, [r3, #2]
 190:	e3530002 	cmp	r3, #2
 194:	1a00008b 	bne	3c8 <GPIO_Pin_init+0x3c8>
 198:	e51b3010 	ldr	r3, [fp, #-16]
 19c:	e5d33000 	ldrb	r3, [r3]
 1a0:	e1a02003 	mov	r2, r3
 1a4:	e59f3230 	ldr	r3, [pc, #560]	@ 3dc <GPIO_Pin_init+0x3dc>
 1a8:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 1ac:	e5932004 	ldr	r2, [r3, #4]
 1b0:	e51b3010 	ldr	r3, [fp, #-16]
 1b4:	e5d33001 	ldrb	r3, [r3, #1]
 1b8:	e1a01003 	mov	r1, r3
 1bc:	e3a03001 	mov	r3, #1
 1c0:	e1a03113 	lsl	r3, r3, r1
 1c4:	e1e03003 	mvn	r3, r3
 1c8:	e1a01003 	mov	r1, r3
 1cc:	e51b3010 	ldr	r3, [fp, #-16]
 1d0:	e5d33000 	ldrb	r3, [r3]
 1d4:	e1a00003 	mov	r0, r3
 1d8:	e59f31fc 	ldr	r3, [pc, #508]	@ 3dc <GPIO_Pin_init+0x3dc>
 1dc:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 1e0:	e0022001 	and	r2, r2, r1
 1e4:	e5832004 	str	r2, [r3, #4]
 1e8:	e51b3010 	ldr	r3, [fp, #-16]
 1ec:	e5d33000 	ldrb	r3, [r3]
 1f0:	e1a02003 	mov	r2, r3
 1f4:	e59f31e0 	ldr	r3, [pc, #480]	@ 3dc <GPIO_Pin_init+0x3dc>
 1f8:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 1fc:	e5932004 	ldr	r2, [r3, #4]
 200:	e51b3010 	ldr	r3, [fp, #-16]
 204:	e5d33004 	ldrb	r3, [r3, #4]
 208:	e1a01003 	mov	r1, r3
 20c:	e51b3010 	ldr	r3, [fp, #-16]
 210:	e5d33001 	ldrb	r3, [r3, #1]
 214:	e1a03311 	lsl	r3, r1, r3
 218:	e1a01003 	mov	r1, r3
 21c:	e51b3010 	ldr	r3, [fp, #-16]
 220:	e5d33000 	ldrb	r3, [r3]
 224:	e1a00003 	mov	r0, r3
 228:	e59f31ac 	ldr	r3, [pc, #428]	@ 3dc <GPIO_Pin_init+0x3dc>
 22c:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 230:	e1822001 	orr	r2, r2, r1
 234:	e5832004 	str	r2, [r3, #4]
 238:	e51b3010 	ldr	r3, [fp, #-16]
 23c:	e5d33000 	ldrb	r3, [r3]
 240:	e1a02003 	mov	r2, r3
 244:	e59f3190 	ldr	r3, [pc, #400]	@ 3dc <GPIO_Pin_init+0x3dc>
 248:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 24c:	e5932008 	ldr	r2, [r3, #8]
 250:	e51b3010 	ldr	r3, [fp, #-16]
 254:	e5d33001 	ldrb	r3, [r3, #1]
 258:	e1a03083 	lsl	r3, r3, #1
 25c:	e3a01003 	mov	r1, #3
 260:	e1a03311 	lsl	r3, r1, r3
 264:	e1e03003 	mvn	r3, r3
 268:	e1a01003 	mov	r1, r3
 26c:	e51b3010 	ldr	r3, [fp, #-16]
 270:	e5d33000 	ldrb	r3, [r3]
 274:	e1a00003 	mov	r0, r3
 278:	e59f315c 	ldr	r3, [pc, #348]	@ 3dc <GPIO_Pin_init+0x3dc>
 27c:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 280:	e0022001 	and	r2, r2, r1
 284:	e5832008 	str	r2, [r3, #8]
 288:	e51b3010 	ldr	r3, [fp, #-16]
 28c:	e5d33000 	ldrb	r3, [r3]
 290:	e1a02003 	mov	r2, r3
 294:	e59f3140 	ldr	r3, [pc, #320]	@ 3dc <GPIO_Pin_init+0x3dc>
 298:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 29c:	e5932008 	ldr	r2, [r3, #8]
 2a0:	e51b3010 	ldr	r3, [fp, #-16]
 2a4:	e5d33003 	ldrb	r3, [r3, #3]
 2a8:	e1a01003 	mov	r1, r3
 2ac:	e51b3010 	ldr	r3, [fp, #-16]
 2b0:	e5d33001 	ldrb	r3, [r3, #1]
 2b4:	e1a03083 	lsl	r3, r3, #1
 2b8:	e1a03311 	lsl	r3, r1, r3
 2bc:	e1a01003 	mov	r1, r3
 2c0:	e51b3010 	ldr	r3, [fp, #-16]
 2c4:	e5d33000 	ldrb	r3, [r3]
 2c8:	e1a00003 	mov	r0, r3
 2cc:	e59f3108 	ldr	r3, [pc, #264]	@ 3dc <GPIO_Pin_init+0x3dc>
 2d0:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 2d4:	e1822001 	orr	r2, r2, r1
 2d8:	e5832008 	str	r2, [r3, #8]
 2dc:	e51b3010 	ldr	r3, [fp, #-16]
 2e0:	e5d33002 	ldrb	r3, [r3, #2]
 2e4:	e3530002 	cmp	r3, #2
 2e8:	1a000036 	bne	3c8 <GPIO_Pin_init+0x3c8>
 2ec:	e51b3010 	ldr	r3, [fp, #-16]
 2f0:	e5d33001 	ldrb	r3, [r3, #1]
 2f4:	e1a031a3 	lsr	r3, r3, #3
 2f8:	e54b3006 	strb	r3, [fp, #-6]
 2fc:	e51b3010 	ldr	r3, [fp, #-16]
 300:	e5d33001 	ldrb	r3, [r3, #1]
 304:	e2033007 	and	r3, r3, #7
 308:	e54b3007 	strb	r3, [fp, #-7]
 30c:	e51b3010 	ldr	r3, [fp, #-16]
 310:	e5d33000 	ldrb	r3, [r3]
 314:	e1a02003 	mov	r2, r3
 318:	e59f30bc 	ldr	r3, [pc, #188]	@ 3dc <GPIO_Pin_init+0x3dc>
 31c:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 320:	e55b2006 	ldrb	r2, [fp, #-6]
 324:	e2822008 	add	r2, r2, #8
 328:	e7931102 	ldr	r1, [r3, r2, lsl #2]
 32c:	e55b3007 	ldrb	r3, [fp, #-7]
 330:	e1a03103 	lsl	r3, r3, #2
 334:	e3a0200f 	mov	r2, #15
 338:	e1a03312 	lsl	r3, r2, r3
 33c:	e1e03003 	mvn	r3, r3
 340:	e1a00003 	mov	r0, r3
 344:	e51b3010 	ldr	r3, [fp, #-16]
 348:	e5d33000 	ldrb	r3, [r3]
 34c:	e1a02003 	mov	r2, r3
 350:	e59f3084 	ldr	r3, [pc, #132]	@ 3dc <GPIO_Pin_init+0x3dc>
 354:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 358:	e55b2006 	ldrb	r2, [fp, #-6]
 35c:	e0011000 	and	r1, r1, r0
 360:	e2822008 	add	r2, r2, #8
 364:	e7831102 	str	r1, [r3, r2, lsl #2]
 368:	e51b3010 	ldr	r3, [fp, #-16]
 36c:	e5d33000 	ldrb	r3, [r3]
 370:	e1a02003 	mov	r2, r3
 374:	e59f3060 	ldr	r3, [pc, #96]	@ 3dc <GPIO_Pin_init+0x3dc>
 378:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 37c:	e55b2006 	ldrb	r2, [fp, #-6]
 380:	e2822008 	add	r2, r2, #8
 384:	e7931102 	ldr	r1, [r3, r2, lsl #2]
 388:	e51b3010 	ldr	r3, [fp, #-16]
 38c:	e5d33006 	ldrb	r3, [r3, #6]
 390:	e1a02003 	mov	r2, r3
 394:	e55b3007 	ldrb	r3, [fp, #-7]
 398:	e1a03103 	lsl	r3, r3, #2
 39c:	e1a03312 	lsl	r3, r2, r3
 3a0:	e1a00003 	mov	r0, r3
 3a4:	e51b3010 	ldr	r3, [fp, #-16]
 3a8:	e5d33000 	ldrb	r3, [r3]
 3ac:	e1a02003 	mov	r2, r3
 3b0:	e59f3024 	ldr	r3, [pc, #36]	@ 3dc <GPIO_Pin_init+0x3dc>
 3b4:	e7933102 	ldr	r3, [r3, r2, lsl #2]
 3b8:	e55b2006 	ldrb	r2, [fp, #-6]
 3bc:	e1811000 	orr	r1, r1, r0
 3c0:	e2822008 	add	r2, r2, #8
 3c4:	e7831102 	str	r1, [r3, r2, lsl #2]
 3c8:	e55b3005 	ldrb	r3, [fp, #-5]
 3cc:	e1a00003 	mov	r0, r3
 3d0:	e28bd000 	add	sp, fp, #0
 3d4:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 3d8:	e12fff1e 	bx	lr
 3dc:	00000000 	.word	0x00000000

000003e0 <GPIO_Set_Pin_Value>:
 3e0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 3e4:	e28db000 	add	fp, sp, #0
 3e8:	e24dd014 	sub	sp, sp, #20
 3ec:	e1a03000 	mov	r3, r0
 3f0:	e54b300d 	strb	r3, [fp, #-13]
 3f4:	e1a03001 	mov	r3, r1
 3f8:	e54b300e 	strb	r3, [fp, #-14]
 3fc:	e1a03002 	mov	r3, r2
 400:	e54b300f 	strb	r3, [fp, #-15]
 404:	e3a03000 	mov	r3, #0
 408:	e54b3005 	strb	r3, [fp, #-5]
 40c:	e55b300d 	ldrb	r3, [fp, #-13]
 410:	e3530005 	cmp	r3, #5
 414:	83a03001 	movhi	r3, #1
 418:	93a03000 	movls	r3, #0
 41c:	e20320ff 	and	r2, r3, #255	@ 0xff
 420:	e55b300e 	ldrb	r3, [fp, #-14]
 424:	e353000f 	cmp	r3, #15
 428:	83a03001 	movhi	r3, #1
 42c:	93a03000 	movls	r3, #0
 430:	e20330ff 	and	r3, r3, #255	@ 0xff
 434:	e1823003 	orr	r3, r2, r3
 438:	e20330ff 	and	r3, r3, #255	@ 0xff
 43c:	e3530000 	cmp	r3, #0
 440:	0a000002 	beq	450 <GPIO_Set_Pin_Value+0x70>
 444:	e3a03001 	mov	r3, #1
 448:	e54b3005 	strb	r3, [fp, #-5]
 44c:	ea000021 	b	4d8 <GPIO_Set_Pin_Value+0xf8>
 450:	e55b300f 	ldrb	r3, [fp, #-15]
 454:	e3530000 	cmp	r3, #0
 458:	1a00000e 	bne	498 <GPIO_Set_Pin_Value+0xb8>
 45c:	e55b300d 	ldrb	r3, [fp, #-13]
 460:	e59f2084 	ldr	r2, [pc, #132]	@ 4ec <GPIO_Set_Pin_Value+0x10c>
 464:	e7923103 	ldr	r3, [r2, r3, lsl #2]
 468:	e5932014 	ldr	r2, [r3, #20]
 46c:	e55b300e 	ldrb	r3, [fp, #-14]
 470:	e3a01001 	mov	r1, #1
 474:	e1a03311 	lsl	r3, r1, r3
 478:	e1e03003 	mvn	r3, r3
 47c:	e1a00003 	mov	r0, r3
 480:	e55b300d 	ldrb	r3, [fp, #-13]
 484:	e59f1060 	ldr	r1, [pc, #96]	@ 4ec <GPIO_Set_Pin_Value+0x10c>
 488:	e7913103 	ldr	r3, [r1, r3, lsl #2]
 48c:	e0022000 	and	r2, r2, r0
 490:	e5832014 	str	r2, [r3, #20]
 494:	ea00000f 	b	4d8 <GPIO_Set_Pin_Value+0xf8>
 498:	e55b300f 	ldrb	r3, [fp, #-15]
 49c:	e3530001 	cmp	r3, #1
 4a0:	1a00000c 	bne	4d8 <GPIO_Set_Pin_Value+0xf8>
 4a4:	e55b300d 	ldrb	r3, [fp, #-13]
 4a8:	e59f203c 	ldr	r2, [pc, #60]	@ 4ec <GPIO_Set_Pin_Value+0x10c>
 4ac:	e7923103 	ldr	r3, [r2, r3, lsl #2]
 4b0:	e5932014 	ldr	r2, [r3, #20]
 4b4:	e55b300e 	ldrb	r3, [fp, #-14]
 4b8:	e3a01001 	mov	r1, #1
 4bc:	e1a03311 	lsl	r3, r1, r3
 4c0:	e1a00003 	mov	r0, r3
 4c4:	e55b300d 	ldrb	r3, [fp, #-13]
 4c8:	e59f101c 	ldr	r1, [pc, #28]	@ 4ec <GPIO_Set_Pin_Value+0x10c>
 4cc:	e7913103 	ldr	r3, [r1, r3, lsl #2]
 4d0:	e1822000 	orr	r2, r2, r0
 4d4:	e5832014 	str	r2, [r3, #20]
 4d8:	e55b3005 	ldrb	r3, [fp, #-5]
 4dc:	e1a00003 	mov	r0, r3
 4e0:	e28bd000 	add	sp, fp, #0
 4e4:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 4e8:	e12fff1e 	bx	lr
 4ec:	00000000 	.word	0x00000000

000004f0 <GPIO_Toggle_Pin_Value>:
 4f0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 4f4:	e28db000 	add	fp, sp, #0
 4f8:	e24dd014 	sub	sp, sp, #20
 4fc:	e1a03000 	mov	r3, r0
 500:	e1a02001 	mov	r2, r1
 504:	e54b300d 	strb	r3, [fp, #-13]
 508:	e1a03002 	mov	r3, r2
 50c:	e54b300e 	strb	r3, [fp, #-14]
 510:	e3a03000 	mov	r3, #0
 514:	e54b3005 	strb	r3, [fp, #-5]
 518:	e55b300d 	ldrb	r3, [fp, #-13]
 51c:	e3530005 	cmp	r3, #5
 520:	83a03001 	movhi	r3, #1
 524:	93a03000 	movls	r3, #0
 528:	e20320ff 	and	r2, r3, #255	@ 0xff
 52c:	e55b300e 	ldrb	r3, [fp, #-14]
 530:	e353000f 	cmp	r3, #15
 534:	83a03001 	movhi	r3, #1
 538:	93a03000 	movls	r3, #0
 53c:	e20330ff 	and	r3, r3, #255	@ 0xff
 540:	e1823003 	orr	r3, r2, r3
 544:	e20330ff 	and	r3, r3, #255	@ 0xff
 548:	e3530000 	cmp	r3, #0
 54c:	0a000002 	beq	55c <GPIO_Toggle_Pin_Value+0x6c>
 550:	e3a03001 	mov	r3, #1
 554:	e54b3005 	strb	r3, [fp, #-5]
 558:	ea00000c 	b	590 <GPIO_Toggle_Pin_Value+0xa0>
 55c:	e55b300d 	ldrb	r3, [fp, #-13]
 560:	e59f203c 	ldr	r2, [pc, #60]	@ 5a4 <GPIO_Toggle_Pin_Value+0xb4>
 564:	e7923103 	ldr	r3, [r2, r3, lsl #2]
 568:	e5932014 	ldr	r2, [r3, #20]
 56c:	e55b300e 	ldrb	r3, [fp, #-14]
 570:	e3a01001 	mov	r1, #1
 574:	e1a03311 	lsl	r3, r1, r3
 578:	e1a00003 	mov	r0, r3
 57c:	e55b300d 	ldrb	r3, [fp, #-13]
 580:	e59f101c 	ldr	r1, [pc, #28]	@ 5a4 <GPIO_Toggle_Pin_Value+0xb4>
 584:	e7913103 	ldr	r3, [r1, r3, lsl #2]
 588:	e0222000 	eor	r2, r2, r0
 58c:	e5832014 	str	r2, [r3, #20]
 590:	e55b3005 	ldrb	r3, [fp, #-5]
 594:	e1a00003 	mov	r0, r3
 598:	e28bd000 	add	sp, fp, #0
 59c:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 5a0:	e12fff1e 	bx	lr
 5a4:	00000000 	.word	0x00000000

000005a8 <GPIO_Get_Pin_Value>:
 5a8:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 5ac:	e28db000 	add	fp, sp, #0
 5b0:	e24dd014 	sub	sp, sp, #20
 5b4:	e1a03000 	mov	r3, r0
 5b8:	e50b2014 	str	r2, [fp, #-20]	@ 0xffffffec
 5bc:	e54b300d 	strb	r3, [fp, #-13]
 5c0:	e1a03001 	mov	r3, r1
 5c4:	e54b300e 	strb	r3, [fp, #-14]
 5c8:	e3a03000 	mov	r3, #0
 5cc:	e54b3005 	strb	r3, [fp, #-5]
 5d0:	e55b300d 	ldrb	r3, [fp, #-13]
 5d4:	e3530005 	cmp	r3, #5
 5d8:	83a03001 	movhi	r3, #1
 5dc:	93a03000 	movls	r3, #0
 5e0:	e20320ff 	and	r2, r3, #255	@ 0xff
 5e4:	e55b300e 	ldrb	r3, [fp, #-14]
 5e8:	e353000f 	cmp	r3, #15
 5ec:	83a03001 	movhi	r3, #1
 5f0:	93a03000 	movls	r3, #0
 5f4:	e20330ff 	and	r3, r3, #255	@ 0xff
 5f8:	e1823003 	orr	r3, r2, r3
 5fc:	e20330ff 	and	r3, r3, #255	@ 0xff
 600:	e1a02003 	mov	r2, r3
 604:	e51b3014 	ldr	r3, [fp, #-20]	@ 0xffffffec
 608:	e3530000 	cmp	r3, #0
 60c:	03a03001 	moveq	r3, #1
 610:	13a03000 	movne	r3, #0
 614:	e20330ff 	and	r3, r3, #255	@ 0xff
 618:	e1823003 	orr	r3, r2, r3
 61c:	e3530000 	cmp	r3, #0
 620:	0a000002 	beq	630 <GPIO_Get_Pin_Value+0x88>
 624:	e3a03001 	mov	r3, #1
 628:	e54b3005 	strb	r3, [fp, #-5]
 62c:	ea000010 	b	674 <GPIO_Get_Pin_Value+0xcc>
 630:	e55b300d 	ldrb	r3, [fp, #-13]
 634:	e59f204c 	ldr	r2, [pc, #76]	@ 688 <GPIO_Get_Pin_Value+0xe0>
 638:	e7923103 	ldr	r3, [r2, r3, lsl #2]
 63c:	e5933010 	ldr	r3, [r3, #16]
 640:	e55b200e 	ldrb	r2, [fp, #-14]
 644:	e3a01001 	mov	r1, #1
 648:	e1a02211 	lsl	r2, r1, r2
 64c:	e0033002 	and	r3, r3, r2
 650:	e3530000 	cmp	r3, #0
 654:	0a000003 	beq	668 <GPIO_Get_Pin_Value+0xc0>
 658:	e51b3014 	ldr	r3, [fp, #-20]	@ 0xffffffec
 65c:	e3a02001 	mov	r2, #1
 660:	e5c32000 	strb	r2, [r3]
 664:	ea000002 	b	674 <GPIO_Get_Pin_Value+0xcc>
 668:	e51b3014 	ldr	r3, [fp, #-20]	@ 0xffffffec
 66c:	e3a02000 	mov	r2, #0
 670:	e5c32000 	strb	r2, [r3]
 674:	e55b3005 	ldrb	r3, [fp, #-5]
 678:	e1a00003 	mov	r0, r3
 67c:	e28bd000 	add	sp, fp, #0
 680:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 684:	e12fff1e 	bx	lr
 688:	00000000 	.word	0x00000000
