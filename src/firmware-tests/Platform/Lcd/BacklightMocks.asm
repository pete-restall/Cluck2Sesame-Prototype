	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledSetLcdBacklightFlag
	global calledClearLcdBacklightFlag

calledSetLcdBacklightFlag res 1
calledClearLcdBacklightFlag res 1

BacklightMocks code
	global initialiseLcdBacklightMocks
	global setLcdBacklightFlag
	global clearLcdBacklightFlag

initialiseLcdBacklightMocks:
	banksel calledSetLcdBacklightFlag
	clrf calledSetLcdBacklightFlag
	clrf calledClearLcdBacklightFlag
	return

setLcdBacklightFlag:
	mockCalled calledSetLcdBacklightFlag
	return

clearLcdBacklightFlag:
	mockCalled calledClearLcdBacklightFlag
	return

	end
