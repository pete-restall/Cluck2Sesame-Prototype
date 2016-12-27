	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

Cordic code
	global sine

sine:
	; TODO: If cordicState != CORDIC_STATE_IDLE then retlw 0, else do the
	; sine magic and retlw 1

	; TODO: This is temporary - passing the first test...
	banksel cordicResult
	movlw 0xff
	movwf cordicResultHigh
	movwf cordicResultLow
	
	return

	end
