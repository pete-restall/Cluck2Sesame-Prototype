	#include "p16f685.inc"

	radix decimal

IsShiftRegisterEnabledStubbedTrue code
	global isShiftRegisterEnabled

isShiftRegisterEnabled:
	retlw 1

	end
