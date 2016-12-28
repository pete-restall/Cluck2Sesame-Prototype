	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

	global isCordicIdle

	defineCordicState CORDIC_STATE_IDLE
	returnFromCordicState

isCordicIdle:
	banksel cordicState
	movf cordicState, W
	xorlw CORDIC_STATE_IDLE
	btfss STATUS, Z
	retlw 0
	retlw 1

	end
