	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_SETTINGS_BACKLIGHTNOW
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT, UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState


		waitForButtonPress UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT, UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		fcall clearLcdBacklightFlag

		waitForButtonPress UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT, UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER
		returnFromUiState

screen:
	da "Backlight (Now) "
	da " ON        [OFF]"

	end
