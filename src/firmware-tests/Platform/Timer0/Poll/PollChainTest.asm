	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"
	#include "../PollAfterTimer0Mock.inc"

	radix decimal

	udata
	global initialT0If

initialT0If res 1

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterTimer0Mock
	fcall initialiseTimer0

	banksel initialT0If
	movf initialT0If
	banksel INTCON
	bcf INTCON, T0IF
	btfss STATUS, Z
	bsf INTCON, T0IF

testAct:
	fcall pollTimer0

testAssert:
	banksel calledPollAfterTimer0
	.assert "calledPollAfterTimer0 != 0, 'Next poll in chain was not called.'"
	return

	end
