	#include "Mcu.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterAdc

calledInitialiseAfterAdc res 1

InitialiseAfterAdcMock code
	global initialiseInitialiseAfterAdcMock
	global INITIALISE_AFTER_ADC

initialiseInitialiseAfterAdcMock:
	banksel calledInitialiseAfterAdc
	clrf calledInitialiseAfterAdc
	return

INITIALISE_AFTER_ADC:
	mockCalled calledInitialiseAfterAdc
	return

	end
