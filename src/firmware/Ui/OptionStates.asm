	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "OptionStates.inc"

ARROW_CHARACTER equ 0x7e

	radix decimal

	defineUiState UI_STATE_OPTION_CHANGED
		banksel uiOptionCounter
		movlw 3
		movwf uiOptionCounter

	defineUiStateInSameSection UI_STATE_OPTION_CHANGED2
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		call loadCurrentPositionIntoFsr

		movlw UI_STATE_OPTION_CHANGED3
		movwf uiState

		movf INDF, W
		fcall setLcdCursorPosition
		returnFromUiState


	defineUiStateInSameSection UI_STATE_OPTION_CHANGED3
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z

		call loadCurrentPositionIntoFsr
		movlw UI_STATE_WAIT_BUTTONPRESS
		decfsz uiOptionCounter
		movlw UI_STATE_OPTION_CHANGED2
		movwf uiState

putArrowIfAtSelectedPositionElsePutSpace:
		movf uiSelectedOptionPosition, W
		xorwf INDF, W
		btfss STATUS, Z
		movlw ' ' - ARROW_CHARACTER
		addlw ARROW_CHARACTER

		fcall putCharacter
		returnFromUiState


loadCurrentPositionIntoFsr:
		bankisel uiOption1Position
		movlw uiOption1Position - 1
		addwf uiOptionCounter, W
		movwf FSR
		return

	end
