	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnsureFastClockCalls
	global numberOfAllowSlowClockCalls
	global expectedOsccon

numberOfEnsureFastClockCalls res 1
numberOfAllowSlowClockCalls res 1
expectedOsccon res 1

ClockSwitchingTest code
	global testArrange

testArrange:
	fcall initialisePowerManagement

testAct:
	banksel numberOfEnsureFastClockCalls
	movf numberOfEnsureFastClockCalls
	btfsc STATUS, Z
	goto callAllowSlowClock

callEnsureFastClock:
	fcall ensureFastClock
	banksel numberOfEnsureFastClockCalls
	decfsz numberOfEnsureFastClockCalls
	goto callEnsureFastClock

callAllowSlowClock:
	banksel numberOfAllowSlowClockCalls
	movf numberOfAllowSlowClockCalls
	btfsc STATUS, Z
	goto testAssert

callAllowSlowClockInLoop:
	fcall allowSlowClock
	banksel numberOfAllowSlowClockCalls
	decfsz numberOfAllowSlowClockCalls
	goto callAllowSlowClockInLoop

testAssert:
	.aliasForAssert OSCCON, _a
	.aliasForAssert expectedOsccon, _b
	.assert "_a == _b, 'OSCCON expectation failure.'"
	return

	end
