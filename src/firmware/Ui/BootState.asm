	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_BOOT
		fcall ensureFastClock
		fcall enableLcd
		setUiState UI_STATE_SETTINGS
		returnFromUiState

	end
