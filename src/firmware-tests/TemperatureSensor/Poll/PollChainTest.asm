	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TemperatureSensor.inc"
	#include "TestFixture.inc"
	#include "../PollAfterTemperatureSensorMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterTemperatureSensorMock
	fcall initialiseTemperatureSensor

testAct:
	fcall pollTemperatureSensor

testAssert:
	banksel calledPollAfterTemperatureSensor
	.assert "calledPollAfterTemperatureSensor != 0, 'Next poll in chain was not called.'"
	return

	end
