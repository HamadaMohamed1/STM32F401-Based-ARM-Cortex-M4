/*
 * i2c.c
 *
 *  Created on: Jun 17, 2024
 *      Author: hamada
 */

#include "../../../Inc/MCAL/I2C/I2C_Interface.h"

static I2C_RegDef_t* I2C_Array[MAX_I2C_NUMBER] = {I2C1,I2C2,I2C3};


Std_RetType_t I2C_init(const I2C_config_t* i2c_obj)
{
	Std_RetType_t ret = RET_OK ;
	if(NULL == i2c_obj)
	{
		ret = RET_ERROR;
	}
	else
	{

	}
	return ret;
}
