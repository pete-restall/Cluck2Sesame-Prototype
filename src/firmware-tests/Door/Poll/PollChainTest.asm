	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Door.inc"
	#include "TestFixture.inc"
	#include "../PollAfterDoorMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterDoorMock
	fcall initialiseDoor

testAct:
	fcall pollDoor

testAssert:
	banksel calledPollAfterDoor
	.assert "calledPollAfterDoor != 0, 'Next poll in chain was not called.'"
	return

	end
