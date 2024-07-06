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


//USART_Config_t my_usart = {.baud_rate = BAUD_9600 , .hardware_control_flow = HARDWARE_FLOW_CONTROL_IS_NOT_USED ,
//		.mode = RX_TX , .oversampling = OVERSAMPLING_BY_16 , .parity = WITHOUT_PARITY ,
//		.source = USART_2 ,.stop_bits = ONE_STOP_BIT , .type = ASYNCHRONOUS , .word_length = EGHIT_BITS , .tx_mode = POLLING , .rx_mode = INTERRUPT
//
//};
//PinConfig_t PA2_TX = { .Port = PORTA ,.Pin = PIN2,.Mode = ALTERNATE_FUNCTION ,.Type=PUSH_PULL
//		, .Speed = MEDUIM , .PullType =PULL_UP ,.AltFunc = AF7
//};
//
//PinConfig_t PA3_RX = { .Port = PORTA ,.Pin = PIN3,.Mode = ALTERNATE_FUNCTION ,.Type=PUSH_PULL
//		, .Speed = MEDUIM , .PullType =PULL_UP ,.AltFunc = AF7
//};

lcd_4bit_t lcd = { .lcd_port = PORTB , .lcd_en_pin = PIN8 ,.lcd_rs_pin = PIN9 ,.lcd_data[0] = PIN4
		,.lcd_data[1] = PIN5 ,.lcd_data[2] = PIN6,.lcd_data[3] = PIN7
};

keypad_t keypad = {.port = PORTA , .kpd_row_pins[0] = PIN0 ,.kpd_row_pins[1] = PIN1 ,.kpd_row_pins[2] = PIN2 ,
		.kpd_row_pins[3] = PIN3 , .kpd_col_pins[0] =PIN4 ,.kpd_col_pins[1] =PIN5 ,
		.kpd_col_pins[2] =PIN6 , .kpd_col_pins[3] =PIN7 ,

};



int main(void)
{
	SystemClock_Config();
	Systick_init();
	RCC_GPIOA_CLK_ENABLE();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOB_CLK_ENABLE();
	//RCC_SYSCFG_CLK_ENABLE();
	scb_set_priority_group(GROUP_PRIORITIES_4_SUB_PRIORITIES_4);	  // preemption
	//cb_set_priority_group(GROUP_PRIORITIES_1_SUB_PRIORITIES_16);   // no preemption because 1 group
	GPIO_Pin_init(&PC13);

//	RCC_USART2_CLK_ENABLE();
//
//	GPIO_Pin_init(&PA2_TX);
//	GPIO_Pin_init(&PA3_RX);
//	USART_init(&my_usart);
//	delay_ms(100);
//		uint8_t ch[] = "Hello Eng: Hamada\n";
//		uint8_t str[250];
//		uint8_t b ='b';
//		USART_send_string_blocking(&my_usart, ch);
//		//USART_receive_string_blocking(&my_usart , str);
//		//USART_send_string_blocking(&my_usart, str);

	//delay_ms(200);
	//lcd_4bit_intialize(&lcd);
	//keypad_initialize(&keypad);
	uint8_t val = '\0';

//	lcd_4bit_send_char_data(&lcd , 'd');

	//lcd_4bit_send_string(&lcd , "Eng : Hamada");





    /* Loop forever */
	while(1)
	{



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


