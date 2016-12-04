	#include "p16f685.inc"

	radix decimal

MotorDummies code
	global initialiseMotor
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled
	global pollMotor

initialiseMotor:
enableMotorVdd:
disableMotorVdd:
pollMotor:
	return

isMotorVddEnabled:
	retlw 0

	end
