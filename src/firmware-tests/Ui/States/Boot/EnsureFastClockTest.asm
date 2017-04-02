	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/PowerManagement/PowerManagementMocks.inc"
	#include "TestFixture.inc"

	radix decimal

EnsureFastClock code
	global testArrange

testArrange:
	fcall initialiseUi
	fcall initialisePowerManagementMocks

testAct:
	setUiState UI_STATE_BOOT
	fcall pollUi

testAssert:
	.aliasForAssert calledEnsureFastClock, _a
	.assert "_a != 0, 'Expected ensureFastClock() to be called.'"
	return

	end
