	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfOverflowsHigh
	global numberOfOverflowsLow
	global expectedSlowTmr0

numberOfOverflowsHigh res 1
numberOfOverflowsLow res 1
expectedSlowTmr0 res 1

counterHigh res 1
counterLow res 1

OverflowIncrementsSlowTimerTest code
	global testArrange

testArrange:
	banksel counterHigh
	clrf counterHigh
	clrf counterLow

	fcall initialiseTimer0

testAct:
	call haveNumberOfOverflowsBeenReached
	xorlw 0
	btfss STATUS, Z
	goto testAssert

	banksel counterLow
	incf counterLow
	movf counterLow
	btfsc STATUS, Z
	incf counterHigh

	banksel INTCON
	bsf INTCON, T0IF
	fcall pollTimer0

	goto testAct

testAssert:
	.aliasForAssert slowTmr0, _a
	.aliasForAssert expectedSlowTmr0, _b
	.assert "_a == _b, 'Expected slowTmr0 == expectedSlowTmr0.'"
	return

haveNumberOfOverflowsBeenReached:
checkForHighByteMatch:
	banksel numberOfOverflowsHigh
	movf numberOfOverflowsHigh, W
	banksel counterHigh
	xorwf counterHigh, W
	btfss STATUS, Z
	retlw 0

checkForLowByteMatch:
	banksel numberOfOverflowsLow
	movf numberOfOverflowsLow, W
	banksel counterLow
	xorwf counterLow, W
	btfss STATUS, Z
	retlw 0

	retlw 1

	end
