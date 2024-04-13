/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  *  Created on: Mar 14, 2024
  *      Author: hamada
  ******************************************************************************/

#include "../Inc/main.h"

Std_RetType_t ret = RET_OK;

PinConfig_t PC13 = { .Port = PORTC ,.Pin = PIN13,.Mode = OUTPUT ,.Type=PUSH_PULL
		, .Speed = MEDUIM , .PullType =NO_PULL
};

void exti_a0_handler(void)
{
	uint8_t c =0;
	c++;
}

uint8_t val = INTERRUPT_NOT_ACTIVE;

PinConfig_t exti_Pin = {.Port = PORTA ,.Pin = PIN0 ,.Mode=INPUT ,.Type =PUSH_PULL ,.Speed = MEDUIM ,.PullType = NO_PULL};

EXTI_config_t exti_a0 = {.EXTI_edge = FALLING_EDGE ,.EXTI_enable_disable = EXTI_ENABLE ,.source =EXTI_0 ,.EXTI_handler = exti_a0_handler};

int main(void)
{
	SystemClock_Config();
	Systick_init();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOA_CLK_ENABLE();
	RCC_SYSCFG_CLK_ENABLE();
	scb_set_priority_group(GROUP_PRIORITIES_4_SUB_PRIORITIES_4);
	GPIO_Pin_init(&PC13);


	GPIO_Pin_init(&exti_Pin); 						// configure a pin as an input

	EXTI_initialize(&exti_a0);						// configure trigger & enable interrupt
	nvic_set_priority(EXTI0_IRQn, 2);				// set interrupt priority via NVIC
	nvic_enable(EXTI0_IRQn);						// enable interrupt via NVIC
	syscfg_set_EXTI_port(EXTI_LINE_0,EXTI_PORT_A);	// configure port in SYSSFG
	EXTI_set_pending_flag(&exti_a0);				// set pending flag;



	//nvic_set_priority(USART2_IRQn,5);//0101   g =1   , s= 1
	//nvic_set_priority(USART1_IRQn,2);//0010   g =0   , s= 2




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
