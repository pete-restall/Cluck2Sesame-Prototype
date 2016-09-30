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
	.assert "calledInitialiseAfterPowerOnReset != 0, \"POR condition did not call initialiseAfterPowerOnReset.\""

	.assert "calledInitialiseAfterBrownOutReset == 0, \"POR condition called initialiseAfterBrownOutReset.\""

	.assert "calledInitialiseAfterMclrReset == 0, \"POR condition called initialiseAfterMclrReset.\""

	.done

	end
