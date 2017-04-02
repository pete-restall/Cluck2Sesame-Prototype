	#define __CLUCK2SESAME_PLATFORM_LCD_WRITE_ASM

	#include "Mcu.inc"
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
	global writeRegisterFromWWithIdleNextState

writeRegisterNibble:
	banksel lcdFlags
	bcf lcdFlags, LCD_FLAG_RS
	goto writeNibble

writeRegister:
	banksel lcdFlags
	bcf lcdFlags, LCD_FLAG_RS
	goto writeHighNibbleOfByte

writeCharacter:
	banksel lcdFlags
	bsf lcdFlags, LCD_FLAG_RS

writeHighNibbleOfByte:
	movwf lcdWorkingRegister
	swapf lcdWorkingRegister, W
	call writeNibble

writeLowNibbleOfByte:
	banksel lcdWorkingRegister
	movf lcdWorkingRegister, W

writeNibble:
	banksel shiftRegisterBuffer
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
	banksel lcdFlags
	btfsc lcdFlags, LCD_FLAG_RS
	iorlw 1 << LCD_RS_BIT

shiftNibble:
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer
	fcall shiftOut

setEnableBit:
	banksel shiftRegisterBuffer
	bsf shiftRegisterBuffer, LCD_EN_BIT
	fcall shiftOut

resetEnableBit:
	banksel shiftRegisterBuffer
	bcf shiftRegisterBuffer, LCD_EN_BIT
	fcall shiftOut
	return

writeRegisterFromWWithIdleNextState:
	banksel lcdWorkingRegister
	movwf lcdWorkingRegister
	movlw LCD_STATE_IDLE
	xorwf lcdState, W
	btfss STATUS, Z
	retlw 0

storeCommandAsParameterForState:
	movlw LCD_STATE_WRITE_REGISTER
	movwf lcdState
	movlw LCD_STATE_IDLE
	movwf lcdNextState
	movf lcdWorkingRegister, W
	movwf lcdStateParameter0
	retlw 1


	defineLcdStateInSameSection LCD_STATE_WRITE_REGISTER
		; TODO: THIS STATE NEEDS WRITING...
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_WRITE_CHARACTER
		; TODO: THIS STATE NEEDS WRITING...
		returnFromLcdState

	end
