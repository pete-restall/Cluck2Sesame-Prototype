	#include "p16f685.inc"

	radix decimal

IsMotorVddEnabledStubbedTrue code
	global isMotorVddEnabled

isMotorVddEnabled:
	retlw 1

	end
