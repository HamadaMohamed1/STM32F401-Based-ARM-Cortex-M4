/*
 * I2C_Interface.h
 *
 *  Created on: Jun 17, 2024
 *      Author: hamada
 */

#ifndef MCAL_I2C_I2C_INTERFACE_H_
#define MCAL_I2C_I2C_INTERFACE_H_

/******************* Includes *******************/
#include "I2C_private.h"

/******************* Data Type Declarations *******************/
typedef struct
{
	I2C_source_t 		source;
	I2C_master_slave_t	master_or_slave;
	I2C_speed_t 		speed;
}I2C_config_t;

/******************* Function Declarations *******************/

Std_RetType_t I2C_init(const I2C_config_t* i2c_obj);
Std_RetType_t I2C_de_init(const I2C_config_t* i2c_obj);
Std_RetType_t I2C_send(const I2C_config_t* i2c_obj ,const uint16_t address ,const uint8_t* data , uint16_t size);
Std_RetType_t I2C_receive(const I2C_config_t* i2c_obj, const uint16_t address ,const uint8_t* data , uint16_t size);


#endif /* MCAL_I2C_I2C_INTERFACE_H_ */
