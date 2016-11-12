	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "../Adc.inc"
	#include "Lcd.inc"
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

	fcall disableAdc
	setLcdState LCD_STATE_DISABLED

	; TODO: ENSURE THAT THE CONTRAST PIN IS SET TO 0V !

disableLcdDone:
	tcall disableShiftRegister

isLcdEnabled:
	; TODO: THIS NEEDS WRITING...HOW TO TEST...?
	;banksel lcdFlags
	;;btfsc lcdFlags, LCD_FLAG_ENABLED
	retlw 1
	;retlw 0

	end
