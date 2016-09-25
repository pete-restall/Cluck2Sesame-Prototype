	#include "p16f685.inc"
	#include "coff.inc"
	radix decimal

	udata
calledInitialiseAfterPowerOnReset res 1
calledInitialiseAfterBrownOutReset res 1

boot code 0x0000
	goto testArrange
	nop
	nop
	nop

isr code 0x0004
	.assert "1 == 0, \"ISR should not be called during this test.\""
	retfie

testArrange:
	banksel calledInitialiseAfterPowerOnReset
	clrf calledInitialiseAfterPowerOnReset

	banksel calledInitialiseAfterBrownOutReset
	clrf calledInitialiseAfterBrownOutReset

testAct:
	extern main
	call main

testAssert:
	.assert "1 == 0, \"TEST MESSAGE\""
	.assert "calledInitialiseAfterPowerOnReset, \"POR condition did not call initialiseAfterPowerOnReset.\""

	.assert "!calledInitialiseAfterBrownOutReset, \"POR condition called initialiseAfterBrownOutReset.\""

	.sim "quit"

	global initialiseAfterPowerOnReset
initialiseAfterPowerOnReset:
	banksel calledInitialiseAfterPowerOnReset
	movlw -1
	movwf calledInitialiseAfterPowerOnReset
	return

	global initialiseAfterBrownOutReset
initialiseAfterBrownOutReset:
	banksel calledInitialiseAfterBrownOutReset
	movlw -1
	movwf calledInitialiseAfterBrownOutReset
	return

	end
