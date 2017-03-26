	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise
	global turnMotorAntiClockwise

turnMotorClockwise:
turnMotorAntiClockwise:
	; TODO: IF motorState != MOTOR_STATE_IDLE || MOTOR_STATE_TURNING_*, RETURN 0...
	; TODO: IF ALREADY TURNING (IN SAME DIRECTION) THEN RETURN 1...

ifAlreadyTurningThenInitialStateIsForReversal:
	banksel CCPR1L
	movf CCPR1L

	banksel motorState
	movlw MOTOR_STATE_SOFTSTART
	btfss STATUS, Z
	movlw MOTOR_STATE_REVERSE

setStatesAndReturn:
	movwf motorState
	movlw MOTOR_STATE_TURNING
	movwf motorStateAfterStarted
	return


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
