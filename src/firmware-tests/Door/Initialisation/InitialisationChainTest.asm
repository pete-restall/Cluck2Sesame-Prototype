	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Door.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterDoorMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterDoorMock

testAct:
	fcall initialiseDoor

testAssert:
	banksel calledInitialiseAfterDoor
	.assert "calledInitialiseAfterDoor != 0, 'Next initialiser in chain was not called.'"
	return

	end
