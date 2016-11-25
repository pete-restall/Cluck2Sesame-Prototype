	#include "p16f685.inc"

	radix decimal

IsMotorVddEnabledDummy code
	global isMotorVddEnabled

isMotorVddEnabled:
	retlw 0

	end
