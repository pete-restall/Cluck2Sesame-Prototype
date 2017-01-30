	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterClockMock.inc"
	#include "../../ResetFlagsStubs.inc"

	radix decimal

	udata
	global isBrownOutReset

isBrownOutReset res 1

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterClockMock

	banksel isBrownOutReset
	movf isBrownOutReset
	btfss STATUS, Z
	goto stubBrownOutReset

stubNonBrownOutReset:
	fcall stubIsLastResetDueToBrownOutToReturnFalse
	goto testAct

stubBrownOutReset:
	fcall stubIsLastResetDueToBrownOutToReturnTrue

testAct:
	fcall initialiseClock

testAssert:
	banksel calledInitialiseAfterClock
	.assert "calledInitialiseAfterClock != 0, 'Next initialiser in chain was not called.'"
	return

	end
