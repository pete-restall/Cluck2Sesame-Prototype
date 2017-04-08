	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "OptionStates.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

ON_CURSOR_POSITION equ LCD_SECOND_LINE | 0
OFF_CURSOR_POSITION equ LCD_SECOND_LINE | 4
AUTO_CURSOR_POSITION equ LCD_SECOND_LINE | 10

	defineUiState UI_STATE_SETTINGS_BACKLIGHTINTHEDARK
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		setButtonPressEventStates UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_LEFT, UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_RIGHT, UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_ENTER

		.setBankFor uiOption1Position
		movlw ON_CURSOR_POSITION
		movwf uiOption1Position

		movlw OFF_CURSOR_POSITION
		movwf uiOption2Position

		movlw AUTO_CURSOR_POSITION
		movwf uiOption3Position
		movwf uiSelectedOptionPosition

		setUiState UI_STATE_OPTION_CHANGED
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_LEFT
		setUiState UI_STATE_OPTION_CHANGED
		movlw AUTO_CURSOR_POSITION
		xorwf uiSelectedOptionPosition, W
		movlw OFF_CURSOR_POSITION
		btfss STATUS, Z
		movlw ON_CURSOR_POSITION
		movwf uiSelectedOptionPosition
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_RIGHT
		setUiState UI_STATE_OPTION_CHANGED
		movlw ON_CURSOR_POSITION
		xorwf uiSelectedOptionPosition, W
		movlw OFF_CURSOR_POSITION
		btfss STATUS, Z
		movlw AUTO_CURSOR_POSITION
		movwf uiSelectedOptionPosition
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_BACKLIGHTINTHEDARK_ENTER
		; TODO: STORE THE RESULT...
		setUiState UI_STATE_SETTINGS_DATETIME
		returnFromUiState

screen:
	da "Backlight (Dark)"
	da " ON  OFF   AUTO "

	end
