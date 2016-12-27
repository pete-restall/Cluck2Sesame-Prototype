	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "../CordicStates.inc"
	#include "TestFixture.inc"

	radix decimal

InitialStateTest code
	global testArrange

testArrange:
	movlw 0xff
	banksel cordicState
	movwf cordicState

testAct:
	fcall initialiseCordic

testAssert:
	.assertStateIs CORDIC_STATE_IDLE
	return

	end
