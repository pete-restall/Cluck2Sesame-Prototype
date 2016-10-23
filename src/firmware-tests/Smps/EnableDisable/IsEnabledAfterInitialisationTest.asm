	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

IsEnabledAfterInitialisationTest code
	global testArrange

testArrange:
	fcall initialiseSmps

testAct:
	movlw 0
	fcall isSmpsEnabled

testAssert:
	.assert "W != 0, 'Expected SMPS to be enabled after initialisation.'"
	return

	end
