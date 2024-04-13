/*
 * EXTI_interface.h
 *
 *  Created on: Apr 12, 2024
 *      Author: hamada
 */

#ifndef MCAL_EXTI_EXTI_INTERFACE_H_
#define MCAL_EXTI_EXTI_INTERFACE_H_

/******************* Includes *******************/
#include "EXTI_private.h"
#include "../../LIBRARY/Common_Macros.h"
#include "../../LIBRARY/Stm32f401xx.h"
/******************* Data type Declaration *******************/
typedef struct
{
	void (* EXTI_handler)(void);
	EXTI_edge_t EXTI_edge;
	uint8_t EXTI_enable_disable;
	EXTI_source_t source;
}EXTI_config_t;


/******************* Interfaces Declaration *******************/
Std_RetType_t EXTI_initialize(const EXTI_config_t* EXTI_object);
Std_RetType_t EXTI_enable(const EXTI_config_t* EXTI_object);
Std_RetType_t EXTI_disable(const EXTI_config_t* EXTI_object);
Std_RetType_t EXTI_set_pending_flag(const EXTI_config_t* EXTI_object);
Std_RetType_t EXTI_clear_pending_flag(const EXTI_config_t* EXTI_object);
Std_RetType_t EXTI_read_pending_flag(const EXTI_config_t* EXTI_object);

#endif /* MCAL_EXTI_EXTI_INTERFACE_H_ */
