/*
 * I2C_private.h
 *
 *  Created on: Jun 17, 2024
 *      Author: hamada
 */

#ifndef MCAL_I2C_I2C_PRIVATE_H_
#define MCAL_I2C_I2C_PRIVATE_H_
/******************* Includes *******************/
#include "../../LIBRARY/Common_Macros.h"
#include "../../LIBRARY/Stm32f401xx.h"
/******************* Macro Declarations *******************/
#define MAX_I2C_NUMBER 		3

							/*I2C_CR1 bits*/
#define SOFTWARE_RESET_BIT_POS 				(15)

/******************* Data Type Declarations *******************/
typedef enum
{
	I2C_1=0,
	I2C_2,
	I2C_3,
}I2C_source_t;

typedef enum
{
	SLAVE_I2C =0,
	MASTER_I2C
}I2C_master_slave_t;

typedef enum
{
	UP_TO_100KHZ =0,
	UP_TO_400KHZ,
}I2C_speed_t;


#endif /* MCAL_I2C_I2C_PRIVATE_H_ */
