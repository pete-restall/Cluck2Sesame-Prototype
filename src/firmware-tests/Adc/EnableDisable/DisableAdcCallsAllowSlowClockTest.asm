	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"
	#include "../../PowerManagement/PowerManagementMocks.inc"

	radix decimal

DisableAdcCallsAllowSlowClockTest code
	global testArrange

testArrange:
	fcall initialisePowerManagementMocks
	fcall initialiseAdc
	fcall enableAdc

testAct:
	fcall disableAdc

testAssert:
	banksel calledAllowSlowClock
	.assert "calledAllowSlowClock != 0, 'Expected allowSlowClock() called.'"
	return

	end
