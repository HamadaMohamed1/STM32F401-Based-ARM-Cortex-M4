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

void exti_b7_handler(void)
{
	uint8_t c =0;
	c++;
}

uint8_t val = INTERRUPT_NOT_ACTIVE;

PinConfig_t exti_Pin = {.Port = PORTB ,.Pin = PIN7 ,.Mode=INPUT ,.Speed = MEDUIM ,.PullType = PULL_UP};

EXTI_config_t exti_b7 = {.EXTI_edge = RISING_EDGE ,.source =EXTI_7 ,.EXTI_handler = exti_b7_handler};

int main(void)
{
	SystemClock_Config();
	Systick_init();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOB_CLK_ENABLE();
	RCC_SYSCFG_CLK_ENABLE();
	scb_set_priority_group(GROUP_PRIORITIES_4_SUB_PRIORITIES_4);
	GPIO_Pin_init(&PC13);


	GPIO_Pin_init(&exti_Pin); 						// configure a pin as an input

	syscfg_set_EXTI_port(EXTI_LINE_7,EXTI_PORT_B);	// configure port in SYSSFG
	EXTI_enable(EXTI_7);							//  enable interrupt
	EXTI_initialize(&exti_b7);						// configure trigger

	nvic_set_priority(EXTI9_5_IRQn, 2);			// set interrupt priority via NVIC
	nvic_enable(EXTI9_5_IRQn);						// enable interrupt via NVIC

	EXTI_set_pending_flag(&exti_b7);				// set pending flag;



	//nvic_set_priority(USART2_IRQn,5);//0101   g =1   , s= 1
	//nvic_set_priority(USART1_IRQn,2);//0010   g =0   , s= 2




    /* Loop forever */
	while(1)
	{
		GPIO_Toggle_Pin_Value(PORTC, PIN13);
		delay_ms(100);

		EXTI_set_pending_flag(&exti_b7);
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
