	#define __CLUCK2SESAME_PLATFORM_MOTOR_REGISTERS_ASM

	#include "Platform.inc"

	radix decimal

MotorRam udata
	global motorFlags

	global motorState
	global motorNextState
	global motorStateParameter0
	global motorStateParameter1
	global motorStateAfterStarted
	global motorStateAfterStopped

	global enableMotorVddCount

	global motorCounter

motorFlags res 1

motorState res 1
motorNextState res 1
motorStateParameter0 res 1
motorStateParameter1 res 1
motorStateAfterStarted res 1
motorStateAfterStopped res 1

enableMotorVddCount res 1

motorCounter res 1

	end
