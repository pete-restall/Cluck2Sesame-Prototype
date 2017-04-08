	#include "Platform.inc"

	radix decimal

	udata
	global motorFlags

motorFlags res 1

MotorDummies code
	global initialiseMotor
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled
	global pollMotor
	global turnMotorClockwise
	global turnMotorAntiClockwise
	global stopMotor

initialiseMotor:
enableMotorVdd:
disableMotorVdd:
pollMotor:
turnMotorClockwise:
turnMotorAntiClockwise:
stopMotor:
	return

isMotorVddEnabled:
	retlw 0

	end
