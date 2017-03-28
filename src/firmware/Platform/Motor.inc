	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_INC
	#define __CLUCK2SESAME_PLATFORM_MOTOR_INC

	radix decimal

MOTOR_FLAG_OVERLOAD equ 0
MOTOR_FLAG_NOMINALLOAD equ 1
MOTOR_FLAG_NOLOAD equ 2

	extern motorFlags

	extern initialiseMotor
	extern enableMotorVdd
	extern disableMotorVdd
	extern isMotorVddEnabled
	extern pollMotor
	extern turnMotorClockwise
	extern turnMotorAntiClockwise

	#endif
