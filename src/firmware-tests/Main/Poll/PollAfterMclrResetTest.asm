	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledPollForWork
	extern calledInitialiseAfterMclrReset
	extern initialiseResetMocks
	extern initialisePollMock
	extern main

PollAfterMclrResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks
	fcall initialisePollMock

testAct:
	fcall main

testAssert:
	.aliasForAssert calledPollForWork, _a
	.aliasForAssert calledInitialiseAfterMclrReset, _b
	.assert "_a > _b, \"Main did not call pollForWork after MCLR initialisation.\""

	.done

	end
