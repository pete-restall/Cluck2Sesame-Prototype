	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialClockSecondBcd

initialClockSecondBcd res 1

IsrDoesNotIncrementTimeTest code
	global testArrange

testArrange:
	banksel initialClockSecondBcd
	clrf initialClockSecondBcd
	movf initialClockSecondBcd, W

	banksel clockSecondBcd
	movwf clockSecondBcd

enableIsr:
	banksel PIR1
	bcf PIR1, TMR1IF

	banksel PIE1
	bsf PIE1, TMR1IE

	banksel INTCON
	bsf INTCON, PEIE
	bsf INTCON, GIE

testAct:
	banksel PIR1
	bsf PIR1, TMR1IF
	nop
	nop

testAssert:
	.aliasForAssert clockSecondBcd, _a
	.aliasForAssert initialClockSecondBcd, _b
	.assert "_a == _b, 'Time should not have been modified.'"
	return

	end
