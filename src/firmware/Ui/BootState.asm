	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_BOOT
		fcall ensureFastClock
		fcall enableLcd
		setUiNextState UI_STATE_SETTINGS
		setUiState UI_STATE_WAIT_LCDENABLED
		returnFromUiState

	end
