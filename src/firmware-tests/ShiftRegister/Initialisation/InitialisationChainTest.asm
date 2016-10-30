	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterShiftRegisterMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterShiftRegisterMock

testAct:
	fcall initialiseShiftRegister

testAssert:
	banksel calledInitialiseAfterShiftRegister
	.assert "calledInitialiseAfterShiftRegister != 0, 'Next initialiser in chain was not called.'"
	return

	end
