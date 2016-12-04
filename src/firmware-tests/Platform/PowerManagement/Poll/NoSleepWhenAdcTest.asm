	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "TestFixture.inc"

	radix decimal

NoSleepWhenAdcTest code
	global testArrange

testArrange:
	fcall initialisePowerManagement

	banksel ADCON0
	bsf ADCON0, ADON

	clrwdt
	banksel WDTCON
	bsf WDTCON, SWDTEN

testAct:
	fcall pollPowerManagement

testAssert:
	banksel STATUS
	btfsc STATUS, NOT_PD
	goto assertSuccess

assertFailure:
	.assert "false, 'Sleep was executed.'"
	return

assertSuccess:
	.assert "true, 'No sleep was executed.'"
	return

	end
