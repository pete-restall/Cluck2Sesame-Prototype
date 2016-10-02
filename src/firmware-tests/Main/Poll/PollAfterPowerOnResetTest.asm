	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledPollTemperatureSensor
	extern calledInitialiseAfterPowerOnReset
	extern initialiseResetMocks
	extern initialisePollMock
	extern main

	global testArrange
	global testAssert

	code
testArrange:
	fcall initialiseResetMocks
	fcall initialisePollMock

testAct:
	fcall main

testAssert:
	.aliasForAssert calledPollTemperatureSensor, _a
	.aliasForAssert calledInitialiseAfterPowerOnReset, _b
	.assert "_a > _b, \"Main did not call pollTemperatureSensor after POR initialisation.\""

	.done

	end
