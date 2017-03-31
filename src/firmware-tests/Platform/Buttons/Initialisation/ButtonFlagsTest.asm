	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"

	radix decimal

ButtonFlagsTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseButtons

testAssert:
	banksel buttonFlags
	.assert "buttonFlags == 0, 'Expected buttonFlags to be cleared.'"

	return

	end
