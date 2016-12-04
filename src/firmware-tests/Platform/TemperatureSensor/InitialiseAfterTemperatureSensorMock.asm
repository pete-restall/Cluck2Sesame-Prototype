	#include "p16f685.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterTemperatureSensor

calledInitialiseAfterTemperatureSensor res 1

InitialiseAfterTemperatureSensorMock code
	global initialiseInitialiseAfterTemperatureSensorMock
	global INITIALISE_AFTER_TEMPERATURESENSOR

initialiseInitialiseAfterTemperatureSensorMock:
	banksel calledInitialiseAfterTemperatureSensor
	clrf calledInitialiseAfterTemperatureSensor
	return

INITIALISE_AFTER_TEMPERATURESENSOR:
	mockCalled calledInitialiseAfterTemperatureSensor
	return

	end
