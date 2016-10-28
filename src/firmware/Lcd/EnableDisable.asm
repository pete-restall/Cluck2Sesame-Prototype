	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "States.inc"

	radix decimal

	udata
	global enableLcdCount

enableLcdCount res 1

Lcd code
	global enableLcd
	global disableLcd
	global isLcdEnabled

enableLcd:
	banksel enableLcdCount
	movf enableLcdCount
	btfss STATUS, Z
	goto enableLcdDone

	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER

enableLcdDone:
	banksel enableLcdCount
	incf enableLcdCount
	tcall enableShiftRegister

disableLcd:
	banksel enableLcdCount
	decfsz enableLcdCount
	goto disableLcdDone

	setLcdState LCD_STATE_DISABLED

disableLcdDone:
	tcall disableShiftRegister

isLcdEnabled:
	; TODO: NEED TO USE A FLAG, WHICH pollLcd() NEEDS TO SET
	return

	end
