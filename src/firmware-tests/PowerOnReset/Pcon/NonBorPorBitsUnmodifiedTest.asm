	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseAfterMclrReset

NON_BOR_POR_MASK equ ~((1 << NOT_BOR) | (1 << NOT_POR))

	udata
initialPcon res 1

NonBorPorBitsUnmodified code
	global testArrange

testArrange:
	banksel PCON
	movf PCON, W
	andlw NON_BOR_POR_MASK

	banksel initialPcon
	movwf initialPcon

testAct:
	fcall initialiseAfterMclrReset

testAssert:
	banksel PCON
	movf PCON, W
	andlw NON_BOR_POR_MASK

	banksel initialPcon
	subwf initialPcon, W
	.aliasWForAssert _a
	.assert "_a == 0, \"Non BOR / POR bits were modified.\""

	.done

	end
