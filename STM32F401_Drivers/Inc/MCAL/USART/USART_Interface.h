/*
 * USART_Interface.h
 *
 *  Created on: Jun 10, 2024
 *      Author: hamada
 */

#ifndef MCAL_USART_USART_INTERFACE_H_
#define MCAL_USART_USART_INTERFACE_H_

/******************* Includes *******************/
#include "USART_Private.h"
/******************* Data Type Declarations *******************/
typedef struct
{
	USART_source_t       			usart_source;
	USART_type_t         			usart_type;
	USART_mode_t         			usart_mode;
	USART_baud_rate_t    			usart_baud_rate;
	USART_stop_bits_t    			usart_stop_bits;
	USART_word_length_t  			usart_word_length;
	USART_parity_t       			usart_parity;
	USART_oversampling_t 			usart_oversampling;
	USART_hardware_control_flow_t   usart_hardware_control_flow;
	void (* USART_Handler)(void);
}USART_Config_t;

/******************* Interfaces Declarations *******************/
Std_RetType_t USART_init(const USART_Config_t* USART_obj);

Std_RetType_t USART_de_init(const USART_Config_t* USART_obj);

Std_RetType_t USART_send_byte(const USART_Config_t* USART_obj , uint8_t byte);

Std_RetType_t USART_receive_byte(const USART_Config_t* USART_obj , uint8_t *byte);

Std_RetType_t USART_send_string(const USART_Config_t* USART_obj , uint8_t *data);

Std_RetType_t USART_recieve_string(const USART_Config_t* USART_obj , uint8_t *data);

/*****************************************************************************/
Std_RetType_t USART_init_DMA(const USART_Config_t* USART_obj);

Std_RetType_t USART_de_init_DMA(const USART_Config_t* USART_obj);

Std_RetType_t USART_send_byte_DMA(const USART_Config_t* USART_obj , uint8_t byte);

Std_RetType_t USART_receive_byte_DMA(const USART_Config_t* USART_obj , uint8_t *byte);



#endif /* MCAL_USART_USART_INTERFACE_H_ */
