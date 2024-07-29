/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  *  Created on: Mar 14, 2024
  *      Author: hamada
  ******************************************************************************/

#include "main.h"
#include <stdio.h>

Std_RetType_t ret = RET_OK;

PinConfig_t PC13 = { .Port = PORTC ,.Pin = PIN13,.Mode = OUTPUT ,.Type=PUSH_PULL
		, .Speed = MEDUIM , .PullType =NO_PULL
};


const char x =4;
const char x0 =4;

void main(void)
{
	
	int var = 0x98;
	//printf("%d" , var);
	SystemClock_Config();
	Systick_init();
	RCC_GPIOA_CLK_ENABLE();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOB_CLK_ENABLE();
	
	//scb_set_priority_group(GROUP_PRIORITIES_4_SUB_PRIORITIES_4);	  
	
	GPIO_Pin_init(&PC13);

	//__asm volatile("msr msp , r3");

    /* Loop forever */
	while(1)
	{

		GPIO_Toggle_Pin_Value(PORTC, PIN13);
		delay_ms(100);

	}

}


Std_RetType_t SystemClock_Config(void)
{
	Std_RetType_t ret = RET_OK;
	RCC_OscInitTypedef RCC_OscInitStruct ={0};
	RCC_ClkInitTypedef RCC_ClkInitStruct ={0};

	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
	RCC_OscInitStruct.HSE_State = RCC_HSE_ON;
	ret = HALL_RCC_OscConfig(&RCC_OscInitStruct);

	RCC_ClkInitStruct.AHBClkDivider  =RCC_SYSCLK_AHB_DIV1;
	RCC_ClkInitStruct.APB1ClkDivider =RCC_HCLK_APB1_DIV1;
	RCC_ClkInitStruct.APB2ClkDivider =RCC_HCLK_APB2_DIV1;
	ret = HALL_RCC_ClockConfig(&RCC_ClkInitStruct);
	return ret;
}


