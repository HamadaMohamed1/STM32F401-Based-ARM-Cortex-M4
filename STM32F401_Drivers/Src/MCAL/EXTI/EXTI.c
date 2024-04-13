/*
 * EXTI.c
 *
 *  Created on: Apr 12, 2024
 *      Author: hamada
 */


#include "../../../Inc/MCAL/EXTI/EXTI_interface.h"

static void (* EXTI_Handler[EXTI_MAX_NUMBER])(void) ={NULL};
static EXTI_source_t EXTI_source ;


Std_RetType_t EXTI_initialize(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{
		//configure edge
		switch(EXTI_object->EXTI_edge)
		{
			case RISING_EDGE :
				EXTI->RTSR |= (1 << EXTI_object->source);
			break;
			case FALLING_EDGE :
				EXTI->FTSR |= (1 << EXTI_object->source);
			break;
			case RISING_FALLING_EDGE :
				EXTI->RTSR |= (1 << EXTI_object->source);
				EXTI->FTSR |= (1 << EXTI_object->source);
			break;
		}
		//enable or disable external interrupt
		EXTI->IMR |= (1 << EXTI_object->EXTI_enable_disable);
		// initiate call back
		EXTI_Handler[EXTI_object->source] = EXTI_object->EXTI_handler;
		// initiate EXTI_source
		EXTI_source = EXTI_object->source;
	}
	return ret;
}
Std_RetType_t EXTI_enable(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{

	}
	return ret;
}
Std_RetType_t EXTI_disable(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{

	}
	return ret;
}
Std_RetType_t EXTI_set_pending_flag(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{
		EXTI->SWIER |= (1 << EXTI_object->source);
	}
	return ret;
}
Std_RetType_t EXTI_clear_pending_flag(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{

	}
	return ret;
}
Std_RetType_t EXTI_read_pending_flag(const EXTI_config_t* EXTI_object)
{
	Std_RetType_t ret = RET_OK;
	if(NULL == EXTI_object)
	{
		ret =  RET_ERROR;
	}
	else
	{

	}
	return ret;
}

void EXTI0_IRQHandler(void)
{
	if(NULL != EXTI_Handler[EXTI_source])
	{
		EXTI_Handler[EXTI_source]();
	}
}
