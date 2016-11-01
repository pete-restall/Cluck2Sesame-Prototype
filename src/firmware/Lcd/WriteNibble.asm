	#define __CLUCK2SESAME_LCD_WRITENIBBLE_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "../ShiftRegister.inc"
	#include "Lcd.inc"

	radix decimal

Lcd code
	global writeNibble

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
	andwf shiftRegisterBuffer

shiftNibble:
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

	end
