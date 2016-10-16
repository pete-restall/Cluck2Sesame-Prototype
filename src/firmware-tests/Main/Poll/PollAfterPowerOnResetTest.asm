	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "TestFixture.inc"
	#include "../PollMockToAssertTest.inc"
	#include "../ResetMocks.inc"

	radix decimal

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
	.assert "_a > _b, 'Main did not call pollForWork after POR initialisation.'"
	.done

	end
