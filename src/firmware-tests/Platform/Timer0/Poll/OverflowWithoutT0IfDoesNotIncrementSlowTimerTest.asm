	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
counter res 1

OverflowWithoutT0IfDoesNotIncrementSlowTimerTest code
	global testArrange

testArrange:
	fcall initialiseTimer0

	banksel counter
	movlw 64
	movwf counter

testAct:
	banksel INTCON
	bcf INTCON, T0IF
	fcall pollTimer0

	banksel counter
	decfsz counter
	goto testAct

testAssert:
	.aliasForAssert slowTmr0, _a
	.assert "_a == 0, 'Expected slowTmr0 == 0.'"
	return

	end
