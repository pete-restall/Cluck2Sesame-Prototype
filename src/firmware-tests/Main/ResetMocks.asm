	#include "p16f685.inc"
	#include "TestDoubles.inc"
	radix decimal

	global calledInitialiseAfterPowerOnReset
	global calledInitialiseAfterBrownOutReset
	global calledInitialiseAfterMclrReset

	udata
calledInitialiseAfterPowerOnReset res 1
calledInitialiseAfterBrownOutReset res 1
calledInitialiseAfterMclrReset res 1

ResetMocks code
	global initialiseResetMocks
	global initialiseAfterPowerOnReset
	global initialiseAfterBrownOutReset
	global initialiseAfterMclrReset

initialiseResetMocks:
	banksel calledInitialiseAfterPowerOnReset
	clrf calledInitialiseAfterPowerOnReset

	banksel calledInitialiseAfterBrownOutReset
	clrf calledInitialiseAfterBrownOutReset

	banksel calledInitialiseAfterMclrReset
	clrf calledInitialiseAfterMclrReset
	return

initialiseAfterPowerOnReset:
	mockCalled calledInitialiseAfterPowerOnReset
	return

initialiseAfterBrownOutReset:
	mockCalled calledInitialiseAfterBrownOutReset
	return

initialiseAfterMclrReset:
	mockCalled calledInitialiseAfterMclrReset
	return

	end