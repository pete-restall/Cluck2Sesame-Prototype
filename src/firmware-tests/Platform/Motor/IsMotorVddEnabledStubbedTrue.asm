	#include "Mcu.inc"

	radix decimal

IsMotorVddEnabledStubbedTrue code
	global isMotorVddEnabled

isMotorVddEnabled:
	retlw 1

	end
