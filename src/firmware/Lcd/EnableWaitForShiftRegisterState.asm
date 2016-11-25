	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER

		fcall isShiftRegisterEnabled
		andlw 0xff
		btfsc STATUS, Z
		goto endOfState
		setLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS

endOfState:
		returnFromLcdState

	end
