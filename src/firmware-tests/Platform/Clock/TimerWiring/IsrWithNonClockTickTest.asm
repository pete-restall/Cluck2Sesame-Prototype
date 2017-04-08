	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "Isr.inc"
	#include "TestFixture.inc"

	radix decimal

IsrWithNonClockTickTest code
	global testArrange

testArrange:
	fcall initialiseIsr
	fcall initialiseClock

enableIsr:
	banksel PIR1
	clrf PIR1

	banksel PIR2
	clrf PIR2

	banksel PIE1
	bsf PIE1, ADIE

	banksel INTCON
	movlw (1 << GIE) | (1 << PEIE)
	movwf INTCON

testAct:
	banksel PIR1
	bsf PIR1, ADIF
	nop
	nop

testAssert:
	banksel clockFlags
	btfsc clockFlags, CLOCK_FLAG_TICKED
	goto assertFailure

assertSuccess:
	.assert "true, 'ISR did not tick the clock.'"
	return

assertFailure:
	.assert "false, 'ISR ticked the clock.'"
	return

	end
