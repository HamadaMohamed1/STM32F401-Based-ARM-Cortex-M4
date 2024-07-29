	.cpu cortex-m4
	.arch armv7e-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.global	ret
	.bss
	.type	ret, %object
	.size	ret, 1
ret:
	.space	1
	.global	PC13
	.data
	.align	2
	.type	PC13, %object
	.size	PC13, 7
PC13:
	.byte	2
	.byte	13
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.space	1
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	bl	SystemClock_Config
	bl	Systick_init
	ldr	r3, .L3
	ldr	r3, [r3, #48]
	ldr	r2, .L3
	orr	r3, r3, #1
	str	r3, [r2, #48]
	ldr	r3, .L3
	ldr	r3, [r3, #48]
	ldr	r2, .L3
	orr	r3, r3, #4
	str	r3, [r2, #48]
	ldr	r3, .L3
	ldr	r3, [r3, #48]
	ldr	r2, .L3
	orr	r3, r3, #2
	str	r3, [r2, #48]
	ldr	r0, .L3+4
	bl	scb_set_priority_group
	ldr	r0, .L3+8
	bl	GPIO_Pin_init
	.syntax unified
@ 33 "main.c" 1
	msr msp , r3
@ 0 "" 2
	.thumb
	.syntax unified
.L2:
	movs	r1, #13
	movs	r0, #2
	bl	GPIO_Toggle_Pin_Value
	mov	r0, #500
	bl	delay_ms
	b	.L2
.L4:
	.align	2
.L3:
	.word	1073887232
	.word	100271360
	.word	PC13
	.size	main, .-main
	.align	1
	.global	SystemClock_Config
	.syntax unified
	.thumb
	.thumb_func
	.type	SystemClock_Config, %function
SystemClock_Config:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #40
	add	r7, sp, #0
	movs	r3, #0
	strb	r3, [r7, #39]
	add	r3, r7, #16
	movs	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	str	r2, [r3, #16]
	adds	r3, r7, #4
	movs	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	movs	r3, #1
	str	r3, [r7, #16]
	movs	r3, #1
	str	r3, [r7, #20]
	add	r3, r7, #16
	mov	r0, r3
	bl	HALL_RCC_OscConfig
	mov	r3, r0
	strb	r3, [r7, #39]
	movs	r3, #0
	str	r3, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #8]
	movs	r3, #0
	str	r3, [r7, #12]
	adds	r3, r7, #4
	mov	r0, r3
	bl	HALL_RCC_ClockConfig
	mov	r3, r0
	strb	r3, [r7, #39]
	ldrb	r3, [r7, #39]	@ zero_extendqisi2
	mov	r0, r3
	adds	r7, r7, #40
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	SystemClock_Config, .-SystemClock_Config
	.ident	"GCC: (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 13.3.1 20240614"
