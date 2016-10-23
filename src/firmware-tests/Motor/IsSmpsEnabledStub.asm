	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
stubReturnValue res 1

IsSmpsEnabledStub code
	global initialiseIsSmpsEnabledStub
	global isSmpsEnabled

initialiseIsSmpsEnabledStub:
	banksel stubReturnValue
	movwf stubReturnValue
	return

isSmpsEnabled:
	banksel stubReturnValue
	movf stubReturnValue, W
	return

	end
