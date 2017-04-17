	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

IsEnabledImmediatelyAfterEnableCallTest code
	global testArrange

testArrange:
	fcall initialiseSmps
	fcall disableSmps
	fcall pollSmps

testAct:
	fcall enableSmps
	fcall isSmpsEnabled

testAssert:
	.assert "W == 0, 'Expected SMPS to be disabled imediately after smpsEnable().'"
	return

	end
