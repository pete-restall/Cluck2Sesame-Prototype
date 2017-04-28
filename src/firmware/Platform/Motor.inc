	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_INC
	#define __CLUCK2SESAME_PLATFORM_MOTOR_INC
	#include "Modules.inc"

	radix decimal

	.module MOTOR

MOTOR_FLAG_OVERLOAD equ 0
MOTOR_FLAG_NOMINALLOAD equ 1
MOTOR_FLAG_NOLOAD equ 2

MOTOR_FLAG_PREVENT_OVERLOAD equ 4 + MOTOR_FLAG_OVERLOAD
MOTOR_FLAG_PREVENT_NOMINALLOAD equ 4 + MOTOR_FLAG_NOMINALLOAD
MOTOR_FLAG_PREVENT_NOLOAD equ 4 + MOTOR_FLAG_NOLOAD

MOTOR_PSTRCON_OUTPUT_MASK equ (1 << STRA) | (1 << STRB)

	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_FLAGSONLY
	.externalVariable motorFlags

	extern initialiseMotor
	extern enableMotorVdd
	extern disableMotorVdd
	extern isMotorVddEnabled
	extern pollMotor
	extern turnMotorClockwise
	extern turnMotorAntiClockwise
	extern stopMotor
	extern isMotorFullyTurning
	#endif

	#endif
