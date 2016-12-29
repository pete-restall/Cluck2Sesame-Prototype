	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STORESINERESULT
		; TODO: CONVERT cordicY FROM Q17.15 TO Q1.15 (WITH SATURATION)...
		banksel cordicResult
		movf cordicYLowerHigh, W
		movwf cordicResultHigh
		movf cordicYLowerLow, W
		movwf cordicResultLow
 nop
 .direct "c", "cordicXUpperHigh"
 .direct "c", "cordicXUpperLow"
 .direct "c", "cordicXLowerHigh"
 .direct "c", "cordicXLowerLow"

 .direct "c", "cordicYUpperHigh"
 .direct "c", "cordicYUpperLow"
 .direct "c", "cordicYLowerHigh"
 .direct "c", "cordicYLowerLow"

 .direct "c", "cordicZUpperHigh"
 .direct "c", "cordicZUpperLow"
 .direct "c", "cordicZLowerHigh"
 .direct "c", "cordicZLowerLow"

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_STORECOSINERESULT
		returnFromCordicState

	end
