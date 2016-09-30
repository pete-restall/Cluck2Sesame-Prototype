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
	.assert "calledInitialiseAfterMclrReset != 0, \"MCLR condition did not call initialiseAfterMclrReset.\""

	.assert "calledInitialiseAfterPowerOnReset == 0, \"MCLR condition called initialiseAfterPowerOnReset.\""

	.assert "calledInitialiseAfterBrownOutReset == 0, \"MCLR condition called initialiseAfterBrownOutReset.\""

	.done

	end
