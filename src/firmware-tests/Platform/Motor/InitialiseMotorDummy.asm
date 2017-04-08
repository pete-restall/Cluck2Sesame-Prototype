	#include "Platform.inc"

	radix decimal

MotorRam udata
	global motorFlags

motorFlags res 1

InitialiseMotorDummy code
	global initialiseMotor

initialiseMotor:
	return

	end
