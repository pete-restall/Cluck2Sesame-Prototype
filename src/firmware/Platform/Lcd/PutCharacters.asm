	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

Lcd code
	global putCharacter
	global putBcdDigit
	global putBcdDigits

putCharacter:
	goto writeCharacterFromWWithIdleNextState

putBcdDigit:
	; TODO: THIS FUNCTION NEEDS WRITING
	retlw 0

putBcdDigits:
	.safelySetBankFor lcdWorkingRegister
	movwf lcdWorkingRegister
	movlw LCD_STATE_IDLE
	xorwf lcdState, W
	btfss STATUS, Z
	retlw 0

storeCommandAsParameterForState:
	movlw LCD_STATE_WRITE_CHARACTER
	movwf lcdState
	movlw LCD_STATE_PUTBCDDIGITS_LSD
	movwf lcdNextState

storeMostSignificantBcdDigit:
	swapf lcdWorkingRegister, W
	andlw 0x0f
	iorlw 0x30
	movwf lcdStateParameter0

storeLeastSignificantBcdDigit:
	movf lcdWorkingRegister, W
	andlw 0x0f
	iorlw 0x30
	movwf lcdStateParameter1
	retlw 1


	defineLcdStateInSameSection LCD_STATE_PUTBCDDIGITS_LSD
		movf lcdStateParameter1, W
		movwf lcdStateParameter0

		movlw LCD_STATE_WRITE_CHARACTER
		movwf lcdState

		movlw LCD_STATE_IDLE
		movwf lcdNextState
		returnFromLcdState

	end
