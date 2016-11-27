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
; TODO: PERFORM A shiftOut() OF ALL ZEROES (EXCEPT SMPS_HIGHPOWER) AND THEN
;       GO TO A NEW STATE THAT ENABLES THE MOTOR VDD, WHICH IN TURN WILL WAIT
;       FOR THE MOTOR VDD AND THEN ONTO LCD_STATE_ENABLE_WAITFORMORETHAN40MS...
		setLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS

endOfState:
		returnFromLcdState

	end
