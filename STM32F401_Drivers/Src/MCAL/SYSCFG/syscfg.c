/*
 * syscfg.c
 *
 *  Created on: Apr 12, 2024
 *      Author: hamada
 */

#include "../../../Inc/MCAL/SYSCFG/syscfg_interface.h"


Std_RetType_t syscfg_set_EXTI_port(EXTI_LINE_t line , uint8_t port)
{
	Std_RetType_t ret = RET_OK;
	uint8_t l_reg_number;
	uint8_t l_bits_number;
	if((line > EXTI_LINE_15)||(port > 7 ))
	{
		ret = RET_ERROR;
	}
	else
	{
		l_reg_number = (line / 4) + 1;
		l_bits_number = (line % 4) * 4;
		switch(l_reg_number)
		{
			case 1:
				SYSCFG->EXTICR1 |= (port << l_bits_number);
			break;
			case 2:
				SYSCFG->EXTICR2 |= (port << l_bits_number);
			break;
			case 3:
				SYSCFG->EXTICR3 |= (port << l_bits_number);
			break;
			case 4:
				SYSCFG->EXTICR4 |= (port << l_bits_number);
			break;
		}
	}
	return ret;
}
