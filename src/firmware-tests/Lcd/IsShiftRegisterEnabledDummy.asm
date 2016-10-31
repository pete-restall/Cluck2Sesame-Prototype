	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

IsShiftRegisterEnabledDummy code
	global isShiftRegisterEnabled

isShiftRegisterEnabled:
	clrw
	return

	end
