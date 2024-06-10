/*
 * USART.c
 *
 *  Created on: Jun 10, 2024
 *      Author: hamada
 */


#include "../../../Inc/MCAL/USART/USART_Interface.h"

static void(* USART_Handler[USART_MAX_NUMBER])(void) = {NULL};
static USART_source_t USART_source;

static USART_RegDef_t* USART_Array[USART_MAX_NUMBER] = {USART1,USART2,USART6};

static void usart_set_baud_rate(const USART_Config_t* USART_obj);


Std_RetType_t USART_init(const USART_Config_t* USART_obj)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == USART_obj)
	{
		ret = RET_ERROR;
	}
	else
	{
		usart_set_baud_rate(USART_obj);

		USART_Array[USART_obj->usart_source]->USART_CR1 |= (1<<(USART_ENABLE_BIT_POS)); //USART Enable
		USART_Array[USART_obj->usart_source]->USART_CR1 |= ((USART_obj->usart_word_length)<<(USART_M_BIT_POS)); //word length 0-> 8bits , 1-> 9bits
		if(WITHOUT_PARITY == USART_obj->usart_parity)
		{
			USART_Array[USART_obj->usart_source]->USART_CR1 &=~ (1<<(USART_PARITY_CONTROL_ENABLE_BIT_POS)); //Disable parity
		}
		else
		{
			USART_Array[USART_obj->usart_source]->USART_CR1 |= (1<<(USART_PARITY_CONTROL_ENABLE_BIT_POS)); //Enable parity
			USART_Array[USART_obj->usart_source]->USART_CR1 |= ((USART_obj->usart_parity)<<(USART_PARITY_SELECTION_BIT_POS)); //Even or Odd parity
		}
		switch(USART_obj->usart_mode)
		{
			case RX_ONLY :
					USART_Array[USART_obj->usart_source]->USART_CR1 |= (1 << (USART_RECEIVER_ENABLE_BIT_POS));// Receiver enable
			break;
			case TX_ONLY :
					USART_Array[USART_obj->usart_source]->USART_CR1 |= (1 << (USART_TRANSMITTER_ENABLE_BIT_POS)); // Transmitter enable
			break ;
			case RX_TX :
					USART_Array[USART_obj->usart_source]->USART_CR1 |= (1 << (USART_RECEIVER_ENABLE_BIT_POS));// Receiver enable
					USART_Array[USART_obj->usart_source]->USART_CR1 |= (1 << (USART_TRANSMITTER_ENABLE_BIT_POS)); // Transmitter enable
			break ;
			default : break;
		}

		USART_Array[USART_obj->usart_source]->USART_CR2 |= ((USART_obj->usart_stop_bits) << (USART_STOP_BITS_POS)); //Stop bits selection

		USART_Array[USART_obj->usart_source]->USART_CR1 |= ((USART_obj->usart_oversampling) << (OVERSAMPLING_BIT_POS)); //Select oversampling mode
	}
	return ret;
}

Std_RetType_t USART_send_byte(const USART_Config_t* USART_obj , uint8_t byte)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == USART_obj)
	{
		ret = RET_ERROR;
	}
	else
	{

		while(!((USART_Array[USART_obj->usart_source]->USART_SR) & 0x00000080));




	}
}

void usart_set_baud_rate(const USART_Config_t* USART_obj)
{
	uint32_t baud_rate = USART_obj->usart_baud_rate;	//baud = (Fck)/(8*(2-OVER8)*USARTDIV);
	uint32_t result;
	uint32_t mantissa;
	uint32_t fraction;
	if(OVERSAMPLING_BY_16==(USART_obj->usart_oversampling))
	{
		result = ((42000000)/(8*2*baud_rate))*1000;
		fraction = (((result%1000)*16)+500)/1000;
	}
	else
	{
		result = ((42000000)/(8*baud_rate))*1000;
		fraction = (((result%1000)*8)+500)/1000;
	}
	mantissa = result/1000;
	USART_Array[USART_obj->usart_source]->USART_BRR |= ((mantissa)<< 4);
	USART_Array[USART_obj->usart_source]->USART_BRR |= ((fraction)<< 0);

}
