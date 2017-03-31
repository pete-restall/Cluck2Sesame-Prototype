	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "Adc.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise
	global turnMotorAntiClockwise

turnMotorClockwise:
	bsf STATUS, C
	goto ensureAdcChannelCanBeUsedToMonitorMotorCurrent

turnMotorAntiClockwise:
	bcf STATUS, C

ensureAdcChannelCanBeUsedToMonitorMotorCurrent:
	movlw MOTOR_ISENSE_ADC_CHANNEL
	fcall setAdcChannel
	xorlw 0
	btfsc STATUS, Z
	retlw 0

	; TODO: IF motorState != MOTOR_STATE_IDLE || MOTOR_STATE_TURNING_*,
	;       RETURN 0.
	; TODO: IF ALREADY TURNING (IN SAME DIRECTION) THEN RETURN 1.
ifAlreadyTurningThenInitialStateIsForReversal:
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
	retlw 1


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
