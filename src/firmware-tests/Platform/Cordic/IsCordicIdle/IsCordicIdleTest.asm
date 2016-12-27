	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	extern cordicState

	udata
	global initialCordicState
	global expectedIsCordicIdle

initialCordicState res 1
expectedIsCordicIdle res 1

IsCordicIdleTest code
	global testArrange

testArrange:
	fcall initialiseCordic

testAct:
	banksel initialCordicState
	movf initialCordicState, W
	banksel cordicState
	movwf cordicState

	fcall isCordicIdle

testAssert:
	banksel expectedIsCordicIdle
	movf expectedIsCordicIdle
	btfss STATUS, Z
	goto assertCordicIsIdleForThisState

assertCordicIsNotIdleForThisState:
	.assert "W == 0, 'Expected isCordicIdle() to return false.'"
	return

assertCordicIsIdleForThisState:
	.assert "W != 0, 'Expected isCordicIdle() to return true.'"
	return

	end
