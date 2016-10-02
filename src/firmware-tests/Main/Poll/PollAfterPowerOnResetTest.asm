	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledPollForWork
	extern calledInitialiseAfterPowerOnReset
	extern initialiseResetMocks
	extern initialisePollMock
	extern main

PollAfterPowerOnResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks
	fcall initialisePollMock

testAct:
	fcall main

testAssert:
	.aliasForAssert calledPollForWork, _a
	.aliasForAssert calledInitialiseAfterPowerOnReset, _b
	.assert "_a > _b, \"Main did not call pollForWork after POR initialisation.\""

	.done

	end
