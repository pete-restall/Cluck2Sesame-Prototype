	#include "Mcu.inc"

	radix decimal

MotorDummies code
	global initialiseMotor
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled
	global pollMotor
	global turnMotorClockwise

initialiseMotor:
enableMotorVdd:
disableMotorVdd:
pollMotor:
turnMotorClockwise:
	return

isMotorVddEnabled:
	retlw 0

	end
