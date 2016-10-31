	#define __CLUCK2SESAME_LCD_WRITENIBBLE_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "../ShiftRegister.inc"
	#include "Lcd.inc"

	radix decimal

Lcd code
	global writeNibble

writeNibble:
 ; TODO: NEED TO FIGURE THIS OUT PROPERLY !  WRITE LOW NIBBLE OF W !
	movlw b'11000000'
	andwf shiftRegisterBuffer, W
	iorlw b'00001100'
	movwf shiftRegisterBuffer

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
