	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableLcdCount
	global calledDisableLcdCount

calledEnableLcdCount res 1
calledDisableLcdCount res 1

EnableDisableLcdMocks code
	global initialiseEnableAndDisableLcdMocks
	global enableLcd
	global disableLcd

initialiseEnableAndDisableLcdMocks:
	banksel calledEnableLcdCount
	clrf calledEnableLcdCount
	clrf calledDisableLcdCount
	return

enableLcd:
	mockIncrementCallCounter calledEnableLcdCount
	return

disableLcd:
	mockIncrementCallCounter calledDisableLcdCount
	return

	end
