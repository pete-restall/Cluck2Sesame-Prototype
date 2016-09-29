	#include "p16f685.inc"
	radix decimal

	global calledInitialiseAfterPowerOnReset
	global calledInitialiseAfterBrownOutReset
	global initialiseAfterPowerOnReset
	global initialiseAfterBrownOutReset

	udata
calledInitialiseAfterPowerOnReset res 1
calledInitialiseAfterBrownOutReset res 1

	code
initialiseAfterPowerOnReset:
	banksel calledInitialiseAfterPowerOnReset
	movlw -1
	movwf calledInitialiseAfterPowerOnReset
	return

initialiseAfterBrownOutReset:
	banksel calledInitialiseAfterBrownOutReset
	movlw -1
	movwf calledInitialiseAfterBrownOutReset
	return

	end
