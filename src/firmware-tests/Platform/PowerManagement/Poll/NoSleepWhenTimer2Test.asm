	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "TestFixture.inc"

	radix decimal

NoSleepWhenTimer2Test code
	global testArrange

testArrange:
	fcall initialisePowerManagement

	banksel T2CON
	bsf T2CON, TMR2ON

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
