	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableAdcCount
	global calledDisableAdcCount

calledEnableAdcCount res 1
calledDisableAdcCount res 1

EnableDisableAdcMocks code
	global initialiseEnableAndDisableAdcMocks
	global enableAdc
	global disableAdc

initialiseEnableAndDisableAdcMocks:
	banksel calledEnableAdcCount
	clrf calledEnableAdcCount
	clrf calledDisableAdcCount
	return

enableAdc:
	mockIncrementCallCounter calledEnableAdcCount
	return

disableAdc:
	mockIncrementCallCounter calledDisableAdcCount
	return

	end
