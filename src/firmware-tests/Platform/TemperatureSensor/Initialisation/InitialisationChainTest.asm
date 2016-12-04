	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TemperatureSensor.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterTemperatureSensorMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterTemperatureSensorMock

testAct:
	fcall initialiseTemperatureSensor

testAssert:
	banksel calledInitialiseAfterTemperatureSensor
	.assert "calledInitialiseAfterTemperatureSensor != 0, 'Next initialiser in chain was not called.'"
	return

	end
