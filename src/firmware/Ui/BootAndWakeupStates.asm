	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "Ui.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_BOOT
		bsf uiFlags, UI_FLAG_PREVENTSLEEP
		setUiNextState UI_STATE_SETTINGS
		goto fullPowerMode

	defineUiStateInSameSection UI_STATE_WAKEUP
		bcf uiFlags, UI_FLAG_PREVENTSLEEP
		setUiNextState UI_STATE_HOME

fullPowerMode:
		setUiState UI_STATE_WAIT_LCDENABLED
		fcall ensureFastClock
		fcall enableLcd
		fcall preventSleep
		returnFromUiState

	end
