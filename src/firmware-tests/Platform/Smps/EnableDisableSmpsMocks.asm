	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableSmpsCount
	global calledEnableSmpsTrisc
	global calledEnableSmpsHighPowerModeCount
	global calledEnableSmpsHighPowerModeTrisc
	global calledDisableSmpsCount
	global calledDisableSmpsTrisc
	global calledDisableSmpsHighPowerModeCount
	global calledDisableSmpsHighPowerModeTrisc

calledEnableSmpsCount res 1
calledEnableSmpsTrisc res 1
calledEnableSmpsHighPowerModeCount res 1
calledEnableSmpsHighPowerModeTrisc res 1
calledDisableSmpsCount res 1
calledDisableSmpsTrisc res 1
calledDisableSmpsHighPowerModeCount res 1
calledDisableSmpsHighPowerModeTrisc res 1

EnableDisableSmpsMocks code
	global initialiseEnableAndDisableSmpsMocks
	global enableSmps
	global enableSmpsHighPowerMode
	global disableSmps
	global disableSmpsHighPowerMode

initialiseEnableAndDisableSmpsMocks:
	banksel calledEnableSmpsCount
	clrf calledEnableSmpsCount
	clrf calledEnableSmpsHighPowerModeCount
	clrf calledDisableSmpsCount
	clrf calledDisableSmpsHighPowerModeCount
	return

enableSmps:
	mockIncrementCallCounter calledEnableSmpsCount

	banksel TRISC
	movf TRISC, W
	banksel calledEnableSmpsTrisc
	movwf calledEnableSmpsTrisc
	return

enableSmpsHighPowerMode:
	mockIncrementCallCounter calledEnableSmpsHighPowerModeCount

	banksel TRISC
	movf TRISC, W
	banksel calledEnableSmpsHighPowerModeTrisc
	movwf calledEnableSmpsHighPowerModeTrisc
	return

disableSmps:
	mockIncrementCallCounter calledDisableSmpsCount

	banksel TRISC
	movf TRISC, W
	banksel calledDisableSmpsTrisc
	movwf calledDisableSmpsTrisc
	return

disableSmpsHighPowerMode:
	mockIncrementCallCounter calledDisableSmpsHighPowerModeCount

	banksel TRISC
	movf TRISC, W
	banksel calledDisableSmpsHighPowerModeTrisc
	movwf calledDisableSmpsHighPowerModeTrisc
	return

	end
