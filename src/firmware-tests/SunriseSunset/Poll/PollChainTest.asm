	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"
	#include "../PollAfterSunriseSunsetMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterSunriseSunsetMock
	fcall initialiseSunriseSunset

testAct:
	fcall pollSunriseSunset

testAssert:
	banksel calledPollAfterSunriseSunset
	.assert "calledPollAfterSunriseSunset != 0, 'Next poll in chain was not called.'"
	return

	end
