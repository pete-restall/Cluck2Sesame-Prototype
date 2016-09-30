	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledInitialiseAfterPowerOnReset
	extern calledInitialiseAfterBrownOutReset
	extern calledInitialiseAfterMclrReset
	extern main

	global testArrange

	code
testArrange:
	banksel calledInitialiseAfterPowerOnReset
	clrf calledInitialiseAfterPowerOnReset

	banksel calledInitialiseAfterBrownOutReset
	clrf calledInitialiseAfterBrownOutReset

	banksel calledInitialiseAfterMclrReset
	clrf calledInitialiseAfterMclrReset

testAct:
	fcall main

testAssert:
	.assert "calledInitialiseAfterBrownOutReset != 0, \"BOR condition did not call initialiseAfterBrownOutReset.\""

	.assert "calledInitialiseAfterPowerOnReset == 0, \"BOR condition called initialiseAfterPowerOnReset.\""

	.assert "calledInitialiseAfterMclrReset == 0, \"BOR condition called initialiseAfterMclrReset.\""

	.done

	end
