	#include "Mcu.inc"

	radix decimal

MotorDummies code
	global initialiseMotor
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled
	global pollMotor
	global turnMotorClockwise
	global turnMotorAntiClockwise

initialiseMotor:
enableMotorVdd:
disableMotorVdd:
pollMotor:
turnMotorClockwise:
turnMotorAntiClockwise:
	return

isMotorVddEnabled:
	retlw 0

	end
