	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
returnValue res 1

IsShiftRegisterEnabledStub code
	global initialiseIsShiftRegisterEnabledStub
	global isShiftRegisterEnabled

initialiseIsShiftRegisterEnabledStub:
	banksel returnValue
	movwf returnValue
	return

isShiftRegisterEnabled:
	banksel returnValue
	movf returnValue, W
	return

	end
