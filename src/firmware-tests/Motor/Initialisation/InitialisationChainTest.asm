	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterMotorMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterMotorMock

testAct:
	fcall initialiseMotor

testAssert:
	.assert "calledInitialiseAfterMotor != 0, 'Next initialiser in chain was not called.'"
	return

	end
