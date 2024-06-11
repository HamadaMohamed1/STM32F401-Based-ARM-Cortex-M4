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

//void usart2_handlar(void)
//{
//	GPIO_Toggle_Pin_Value(PORTC, PIN13);
//
//}

volatile uint8_t num = 0 ;

USART_Config_t my_usart = {.baud_rate = 9600 , .hardware_control_flow = HARDWARE_FLOW_CONTROL_IS_NOT_USED ,
		.mode = RX_TX , .oversampling = OVERSAMPLING_BY_16 , .parity = WITHOUT_PARITY ,
		.source = USART_2 ,.stop_bits = ONE_STOP_BIT , .type = ASYNCHRONOUS , .word_length = EGHIT_BITS , .tx_mode = POLLING , .rx_mode = POLLING

};



PinConfig_t PA2_TX = { .Port = PORTA ,.Pin = PIN2,.Mode = ALTERNATE_FUNCTION ,.Type=PUSH_PULL
		, .Speed = MEDUIM , .PullType =PULL_UP ,.AltFunc = AF7
};

PinConfig_t PA3_RX = { .Port = PORTA ,.Pin = PIN3,.Mode = ALTERNATE_FUNCTION ,.Type=PUSH_PULL
		, .Speed = MEDUIM , .PullType =PULL_UP ,.AltFunc = AF7
};
uint8_t ch;
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

	RCC_GPIOA_CLK_ENABLE();
	RCC_USART2_CLK_ENABLE();

	GPIO_Pin_init(&PA2_TX);
	GPIO_Pin_init(&PA3_RX);

	USART_init(&my_usart);


//	USART_send_byte_blocking(&my_usart, 'H');
//	delay_ms(50);
//	USART_receive_byte_blocking(&my_usart, &ch);
//	delay_ms(50);
//	USART_send_byte_blocking(&my_usart, '\r');
//	USART_send_byte_blocking(&my_usart, ch);

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



	uint8_t ch[] = "hamada mohamed elsayed";
	uint8_t str[20];
	USART_send_string_blocking(&my_usart, ch);

	USART_receive_string_blocking(&my_usart , str);

	USART_send_string_blocking(&my_usart, str);
	//uint8_t ch ;
	//USART_receive_byte_IT(&my_usart,&ch);
    /* Loop forever */
	while(1)
	{
		//USART_receive_byte_IT(&my_usart,&ch);
		GPIO_Toggle_Pin_Value(PORTC, PIN13);
		delay_ms(100);
		//USART_send_byte_IT(&my_usart,'H');
//		if(ch == '1')
//		{
//			GPIO_Set_Pin_Value(PORTC, PIN13, PIN_LOW);
//		}
//		if(ch == '0')
//		{
//			GPIO_Set_Pin_Value(PORTC, PIN13, PIN_HIGH);
//		}
//		if(ch == '2')
//		{
//			USART_send_byte_IT(&my_usart,'z');
//		}
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


