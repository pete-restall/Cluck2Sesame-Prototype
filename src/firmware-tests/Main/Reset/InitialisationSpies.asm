	#include "p16f685.inc"
	#include "TestDoubles.inc"
	radix decimal

	global calledInitialiseAfterPowerOnReset
	global calledInitialiseAfterBrownOutReset
	global calledInitialiseAfterMclrReset
	global initialiseAfterPowerOnReset
	global initialiseAfterBrownOutReset
	global initialiseAfterMclrReset

	udata
calledInitialiseAfterPowerOnReset res 1
calledInitialiseAfterBrownOutReset res 1
calledInitialiseAfterMclrReset res 1

	code
initialiseAfterPowerOnReset:
	spyCalled calledInitialiseAfterPowerOnReset
	return

initialiseAfterBrownOutReset:
	spyCalled calledInitialiseAfterBrownOutReset
	return

initialiseAfterMclrReset:
	spyCalled calledInitialiseAfterMclrReset
	return

	end
