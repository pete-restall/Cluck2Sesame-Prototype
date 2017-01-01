	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	extern cordicState

	udata
initialState res 1
initialResultHigh res 1
initialResultLow res 1

ArcSineWhenNotIdleTest code
	global testArrange

testArrange:
	fcall initialiseCordic

setCordicResultHighToAnything:
	banksel TMR0
	movf TMR0, W
	banksel initialResultHigh
	movwf initialResultHigh
	banksel cordicResultHigh
	movwf cordicResultHigh

setCordicStateToAnyNonIdleValue:
	banksel TMR0
	movf TMR0, W
	banksel initialState
	movwf initialState
	movwf cordicState
	btfsc STATUS, Z
	comf cordicState

setCordicResultLowToAnything:
	banksel TMR0
	movf TMR0, W
	banksel initialResultLow
	movwf initialResultLow
	banksel cordicResultLow
	movwf cordicResultLow

testAct:
	fcall arcSine

testAssert:
	.assert "W == 0, 'Expected W == 0.'"

	.aliasForAssert cordicState, _a
	.aliasForAssert initialState, _b
	.assert "_a == _b, 'Expected cordicState to be unchanged.'"

	.aliasForAssert cordicResultHigh, _a
	.aliasForAssert initialResultHigh, _b
	.assert "_a == _b, 'Expected cordicResultHigh to be unchanged.'"

	.aliasForAssert cordicResultLow, _a
	.aliasForAssert initialResultLow, _b
	.assert "_a == _b, 'Expected cordicResultLow to be unchanged.'"
	return

	end
