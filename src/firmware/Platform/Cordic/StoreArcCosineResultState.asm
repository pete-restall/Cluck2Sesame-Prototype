	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STOREARCCOSINERESULT
		banksel RBA
		clrf RBA
		clrf RBB
		movlw high(DEGREES_90)
		movwf RBC
		movlw low(DEGREES_90)
		movwf RBD

		call loadCordicZIntoA
		fcall add32
		call storeSaturatedAIntoCordicResultQ15

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState

	end
