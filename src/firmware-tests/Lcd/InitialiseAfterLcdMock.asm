	#include "p16f685.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterLcd

calledInitialiseAfterLcd res 1

InitialiseAfterLcdMock code
	global initialiseInitialiseAfterLcdMock
	global INITIALISE_AFTER_LCD

initialiseInitialiseAfterLcdMock:
	banksel calledInitialiseAfterLcd
	clrf calledInitialiseAfterLcd
	return

INITIALISE_AFTER_LCD:
	mockCalled calledInitialiseAfterLcd
	return

	end
