/*
 * main.h
 *
 *  Created on: Mar 14, 2024
 *      Author: hamada
 */

#ifndef MAIN_H_
#define MAIN_H_

/******************* Includes *******************/

#include "Common_Macros.h"
#include "RCC.h"
#include "GPIO_Interface.h"
#include "SystTick_Interface.h"
#include "SCB_Interface.h"
/******************* Interfaces Declaration *******************/

Std_RetType_t SystemClock_Config(void);


#endif /* MAIN_H_ */
