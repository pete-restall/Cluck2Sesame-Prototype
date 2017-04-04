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
		goto returnFromState

		fcall setLcdBacklightFlag ; TODO: THIS SHOULDN'T BE THE DEFAULT STATE - MIGHT DRAIN THE BATTERY IF A SPONTANEOUS RESET OCCURS...
		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT, UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER

returnFromState:
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER
		returnFromUiState

screen:
	da "Backlight (Now) "
	da " ON        [OFF]"

	end
