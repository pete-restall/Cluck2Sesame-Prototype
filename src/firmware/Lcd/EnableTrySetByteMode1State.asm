	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_TRYSETBYTEMODE1
	banksel shiftRegisterBuffer
setNibbleInShiftRegisterBuffer:
	movlw b'11000000'
	andwf shiftRegisterBuffer
	bsf shiftRegisterBuffer, LCD_DB5_BIT
	bsf shiftRegisterBuffer, LCD_DB4_BIT

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
	returnFromLcdState

	end
