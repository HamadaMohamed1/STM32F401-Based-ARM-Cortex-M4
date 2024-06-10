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


volatile uint8_t num = 0 ;

USART_Config_t my_usart = { .USART_Handler =NULL , .usart_baud_rate = 9600 , .usart_hardware_control_flow = HARDWARE_FLOW_CONTROL_IS_NOT_USED ,
		.usart_mode = RX_TX , .usart_oversampling = OVERSAMPLING_BY_8 , .usart_parity = ODD_PARITY ,
		.usart_source = USART_2 ,.usart_stop_bits = TWO_STOP_BITS , .usart_type = ASYNCHRONOUS , .usart_word_length = NINE_BITS

};


int main(void)
{
	SystemClock_Config();
	Systick_init();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOB_CLK_ENABLE();
	//RCC_SYSCFG_CLK_ENABLE();
	scb_set_priority_group(GROUP_PRIORITIES_4_SUB_PRIORITIES_4);	  // preemption
	//cb_set_priority_group(GROUP_PRIORITIES_1_SUB_PRIORITIES_16);   // no preemption because 1 group
	GPIO_Pin_init(&PC13);

	RCC_USART2_CLK_ENABLE();
	USART_init(&my_usart);

//
//
//	nvic_enable(ADC_IRQn);
//	nvic_set_priority(ADC_IRQn,10);      //10->1010		 g =2  ,  s=2
//	//nvic_set_priority(ADC_IRQn,1);		//1-> 0001       g =0   , s= 1          highest priority than usart2
//
//
//
//	nvic_enable(USART2_IRQn);
//	nvic_set_priority(USART2_IRQn,5);	//0101   g =1   , s= 1
//
//	nvic_set_pending_flag(USART2_IRQn);




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


void USART2_IRQHandler(void)
{

	num++;
	num++;
	nvic_set_pending_flag(ADC_IRQn);
	num++;
}

void ADC_IRQHandler(void)
{
	num+=5;
}
