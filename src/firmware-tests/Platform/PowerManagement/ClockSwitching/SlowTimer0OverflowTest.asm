	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfAdditionalEnsureFastClockCalls
	global initialSlowTmr0
	global expectedSlowTmr0

numberOfAdditionalEnsureFastClockCalls res 1
initialSlowTmr0 res 1
expectedSlowTmr0 res 1

SlowTimer0OverflowTest code
	global testArrange

testArrange:
	fcall initialiseTimer0

disableTmr0:
	banksel OPTION_REG
	movlw 1 << T0CS
	movwf OPTION_REG

	fcall initialisePowerManagement
	fcall allowSlowClock

callEnsureFastClockIfFixtureRequiresIt:
	banksel numberOfAdditionalEnsureFastClockCalls
	movf numberOfAdditionalEnsureFastClockCalls
	btfsc STATUS, Z
	goto primeSlowTmr0ForIncrement

callAdditionalEnsureFastClock:
	fcall ensureFastClock
	banksel numberOfAdditionalEnsureFastClockCalls
	decfsz numberOfAdditionalEnsureFastClockCalls
	goto callAdditionalEnsureFastClock

primeSlowTmr0ForIncrement:
	variable i = 0
	while (i < 7)
		call flagTmr0Overflow
i = i + 1
	endw

	banksel initialSlowTmr0
	movf initialSlowTmr0, W
	banksel slowTmr0
	movwf slowTmr0

testAct:
	fcall ensureFastClock
	call flagTmr0Overflow

testAssert:
	.aliasForAssert slowTmr0, _a
	.aliasForAssert expectedSlowTmr0, _b
	.assert "_a == _b, 'Expected slowTmr0 == expectedSlowTmr0.'"
	return

flagTmr0Overflow:
	banksel INTCON
	bsf INTCON, T0IF
	fcall pollTimer0
	return

	end
