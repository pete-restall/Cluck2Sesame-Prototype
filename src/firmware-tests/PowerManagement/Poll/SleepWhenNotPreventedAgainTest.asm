	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "TestFixture.inc"

	radix decimal

SleepWhenNotPreventedAgainTest code
	global testArrange

testArrange:
	fcall initialisePowerManagement

	clrwdt
	banksel WDTCON
	bsf WDTCON, SWDTEN

testAct:
	fcall preventSleep
	fcall pollPowerManagement
	fcall pollPowerManagement

testAssert:
	banksel STATUS
	btfss STATUS, NOT_PD
	goto assertSuccess

assertFailure:
	.assert "false, 'No sleep was executed.'"
	return

assertSuccess:
	.assert "true, 'Sleep was executed.'"
	return

	end
