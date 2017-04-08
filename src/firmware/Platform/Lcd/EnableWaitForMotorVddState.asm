	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "../Motor.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_WAITFORMOTORVDD
		fcall isMotorVddEnabled
		xorlw 0
		btfsc STATUS, Z
		goto endOfState

		setLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS

endOfState:
		returnFromLcdState

	end
