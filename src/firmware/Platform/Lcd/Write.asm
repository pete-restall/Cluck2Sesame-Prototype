	#define __CLUCK2SESAME_PLATFORM_LCD_WRITE_ASM

	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

Lcd code
	global writeRegister
	global writeCharacter
	global writeRegisterNibble
	global writeCharacterFromWWithIdleNextState
	global writeRegisterFromWWithIdleNextState

writeRegisterNibble:
	.safelySetBankFor lcdFlags
	bcf lcdFlags, LCD_FLAG_RS
	goto writeNibble

writeRegister:
	.safelySetBankFor lcdFlags
	bcf lcdFlags, LCD_FLAG_RS
	goto writeHighNibbleOfByte

writeCharacter:
	.safelySetBankFor lcdFlags
	bsf lcdFlags, LCD_FLAG_RS

writeHighNibbleOfByte:
	movwf lcdWorkingRegister
	swapf lcdWorkingRegister, W
	call writeNibble

writeLowNibbleOfByte:
	.safelySetBankFor lcdWorkingRegister
	movf lcdWorkingRegister, W

writeNibble:
	.safelySetBankFor shiftRegisterBuffer
	andlw b'00001111'

preserveNonLcdDataBitsInShiftRegisterBuffer:
	btfsc shiftRegisterBuffer, 7
	iorlw b'00100000'
	btfsc shiftRegisterBuffer, 6
	iorlw b'00010000'

moveLcdDataBitsIntoPlaceInShiftRegisterBuffer:
	movwf shiftRegisterBuffer
	rlf shiftRegisterBuffer
	rlf shiftRegisterBuffer
	movlw b'11111100'
	andwf shiftRegisterBuffer, W

selectRegisterOrCharacterWrite:
	.setBankFor lcdFlags
	btfsc lcdFlags, LCD_FLAG_RS
	iorlw 1 << LCD_RS_BIT

shiftNibble:
	.setBankFor shiftRegisterBuffer
	movwf shiftRegisterBuffer
	fcall shiftOut

setEnableBit:
	.setBankFor shiftRegisterBuffer
	bsf shiftRegisterBuffer, LCD_EN_BIT
	fcall shiftOut

resetEnableBit:
	.setBankFor shiftRegisterBuffer
	bcf shiftRegisterBuffer, LCD_EN_BIT
	fcall shiftOut
	return


writeCharacterFromWWithIdleNextState:
	bcf STATUS, C
	goto ensureWriteOnlyWhenIdle

writeRegisterFromWWithIdleNextState:
	bsf STATUS, C

ensureWriteOnlyWhenIdle:
	.safelySetBankFor lcdWorkingRegister
	movwf lcdWorkingRegister
	movlw LCD_STATE_IDLE
	xorwf lcdState, W
	btfss STATUS, Z
	retlw 0

storeCommandAsParameterForState:
	movlw LCD_STATE_WRITE_REGISTER
	btfss STATUS, C
	movlw LCD_STATE_WRITE_CHARACTER
	movwf lcdState
	movlw LCD_STATE_IDLE
	movwf lcdNextState
	movf lcdWorkingRegister, W
	movwf lcdStateParameter0
	retlw 1


	defineLcdStateInSameSection LCD_STATE_WRITE_REGISTER
		.setBankFor lcdNextState
		movf lcdNextState, W
		movwf lcdState
		movf lcdStateParameter0, W
		call writeRegister
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_WRITE_CHARACTER
		.setBankFor lcdNextState
		movf lcdNextState, W
		movwf lcdState
		movf lcdStateParameter0, W
		call writeCharacter
		returnFromLcdState

	end
