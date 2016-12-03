	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterPowerManagementMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterPowerManagementMock

testAct:
	fcall initialisePowerManagement

testAssert:
	banksel calledInitialiseAfterPowerManagement
	.assert "calledInitialiseAfterPowerManagement != 0, 'Next initialiser in chain was not called.'"
	return

	end
