	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAdc
	global calledEnableAdc
	global calledDisableAdc

calledInitialiseAdc res 1
calledEnableAdc res 1
calledDisableAdc res 1

AdcMocks code
	global initialiseAdcMocks
	global initialiseAdc
	global enableAdc
	global disableAdc

initialiseAdcMocks:
	banksel calledInitialiseAdc
	clrf calledInitialiseAdc
	clrf calledEnableAdc
	clrf calledDisableAdc
	return

initialiseAdc:
	mockIncrementCallCounter calledInitialiseAdc
	return

enableAdc:
	mockIncrementCallCounter calledEnableAdc
	return

disableAdc:
	mockIncrementCallCounter calledDisableAdc
	return

	end
