	#include "Mcu.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterSunriseSunset

calledInitialiseAfterSunriseSunset res 1

InitialiseAfterSunriseSunsetMock code
	global initialiseInitialiseAfterSunriseSunsetMock
	global INITIALISE_AFTER_SUNRISESUNSET

initialiseInitialiseAfterSunriseSunsetMock:
	banksel calledInitialiseAfterSunriseSunset
	clrf calledInitialiseAfterSunriseSunset
	return

INITIALISE_AFTER_SUNRISESUNSET:
	mockCalled calledInitialiseAfterSunriseSunset
	return

	end
