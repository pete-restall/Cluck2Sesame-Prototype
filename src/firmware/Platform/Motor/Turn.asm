	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise
	global turnMotorAntiClockwise

turnMotorClockwise:
	bsf STATUS, C
	goto ifAlreadyTurningThenInitialStateIsForReversal

turnMotorAntiClockwise:
	bcf STATUS, C

ifAlreadyTurningThenInitialStateIsForReversal:
	; TODO: IF motorState != MOTOR_STATE_IDLE || MOTOR_STATE_TURNING_*,
	;       RETURN 0.
	; TODO: IF ALREADY TURNING (IN SAME DIRECTION) THEN RETURN 1.
	; TODO: ONLY START TURNING IF ADC CHANNEL CAN BE CHANGED / LOCKED (IE. NOT
	;       IN USE BY ANOTHER MODULE); IF CANNOT CHANGE CHANNEL THEN RETURN 0.
	banksel CCPR1L
	movf CCPR1L
	btfss STATUS, Z
	goto reverseMotor

startMotor:
	banksel PSTRCON
	btfsc STATUS, C
	bsf PSTRCON, STRA
	btfss STATUS, C
	bsf PSTRCON, STRB

	banksel motorState
	movlw MOTOR_STATE_SOFTSTART
	goto setStatesAndReturn

reverseMotor:
	banksel motorState
	movlw MOTOR_STATE_REVERSE

setStatesAndReturn:
	movwf motorState
	movlw MOTOR_STATE_TURNING
	movwf motorStateAfterStarted
	return


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
