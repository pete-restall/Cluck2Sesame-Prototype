	#define __CLUCK2SESAME_PLATFORM_MOTOR_REGISTERS_ASM

	#include "Mcu.inc"

	radix decimal

	udata
	global motorState
	global motorNextState
	global motorStateParameter0
	global motorStateParameter1

	global enableMotorVddCount

	global motorCounter

motorState res 1
motorNextState res 1
motorStateParameter0 res 1
motorStateParameter1 res 1

enableMotorVddCount res 1

motorCounter res 1

	end
