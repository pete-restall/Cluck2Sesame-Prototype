	#include "p16f685.inc"

	radix decimal

IsShiftRegisterEnabledDummy code
	global isShiftRegisterEnabled

isShiftRegisterEnabled:
	retlw 0

	end
