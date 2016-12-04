	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"
	#include "../../PowerManagement/PowerManagementMocks.inc"

	radix decimal

EnableAdcCallsEnsureFastClockTest code
	global testArrange

testArrange:
	fcall initialisePowerManagementMocks
	fcall initialiseAdc

testAct:
	fcall enableAdc

testAssert:
	banksel calledEnsureFastClock
	.assert "calledEnsureFastClock != 0, 'Expected ensureFastClock() called.'"
	return

	end
