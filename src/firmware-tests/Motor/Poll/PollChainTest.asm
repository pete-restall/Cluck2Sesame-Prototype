	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"
	#include "../PollAfterMotorMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterMotorMock
	fcall initialiseMotor

testAct:
	fcall pollMotor

testAssert:
	.assert "calledPollAfterMotor != 0, 'Next poll in chain was not called.'"
	return

	end