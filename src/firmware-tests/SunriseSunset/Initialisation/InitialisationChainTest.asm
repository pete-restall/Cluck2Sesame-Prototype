	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterSunriseSunsetMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterSunriseSunsetMock

testAct:
	fcall initialiseSunriseSunset

testAssert:
	banksel calledInitialiseAfterSunriseSunset
	.assert "calledInitialiseAfterSunriseSunset != 0, 'Next initialiser in chain was not called.'"
	return

	end
