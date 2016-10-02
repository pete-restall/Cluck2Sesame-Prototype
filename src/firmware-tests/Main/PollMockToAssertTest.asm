	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "TestDoubles.inc"
	radix decimal

	extern testAssert

	global calledPollTemperatureSensor
	global initialisePollMock
	global pollTemperatureSensor

	udata
calledPollTemperatureSensor res 1

	code
initialisePollMock:
	banksel calledPollTemperatureSensor
	clrf calledPollTemperatureSensor
	return

pollTemperatureSensor:
	mockCalled calledPollTemperatureSensor
	tcall testAssert

	end
