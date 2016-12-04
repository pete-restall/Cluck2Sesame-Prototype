	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "../Motor.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER

		fcall isShiftRegisterEnabled
		andlw 0xff
		btfsc STATUS, Z
		goto endOfState

clearShiftRegister:
		banksel shiftRegisterBuffer
		movlw NON_LCD_BITS_MASK
		andwf shiftRegisterBuffer
		fcall shiftOut

enableLcdPowerSupply:
		fcall enableMotorVdd
		setLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS

endOfState:
		returnFromLcdState

	end
