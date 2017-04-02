	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../UiStates.inc"
	#include "TestFixture.inc"

	radix decimal

InitialStateTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseUi

testAssert:
	.assertStateIs UI_STATE_BOOT
	return

	end
