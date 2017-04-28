	#include "Platform.inc"

	radix decimal

TurnMotorDummies code
	global turnMotorClockwise
	global turnMotorAntiClockwise
	global stopMotor
	global isMotorFullyTurning

turnMotorClockwise:
turnMotorAntiClockwise:
stopMotor:
	return

isMotorFullyTurning:
	retlw 0

	end
