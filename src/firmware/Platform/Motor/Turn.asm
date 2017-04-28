	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "Adc.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise
	global turnMotorAntiClockwise
	global isMotorFullyTurning

turnMotorClockwise:
	.safelySetBankFor motorFlags
	bsf motorFlags, MOTOR_FLAG_DIRECTION_CLOCKWISE
	goto ensureMotorIsInSteadyState

turnMotorAntiClockwise:
	.safelySetBankFor motorFlags
	bcf motorFlags, MOTOR_FLAG_DIRECTION_CLOCKWISE

ensureMotorIsInSteadyState:
	.knownBank motorFlags

checkIfMotorIsInIdleState:
	movf motorState, W
	xorlw MOTOR_STATE_IDLE
	btfsc STATUS, Z
	goto ensureAdcChannelCanBeUsedToMonitorMotorCurrent

ensureMotorIsInTurningState:
	call isMotorFullyTurning
	.knownBank motorState
	btfss STATUS, Z
	retlw 0

ensureAdcChannelCanBeUsedToMonitorMotorCurrent:
	; TODO: IF ADC IS NOT ENABLED THEN RETURN 0.
	movlw MOTOR_ISENSE_ADC_CHANNEL
	fcall setAdcChannel
	xorlw 0
	btfsc STATUS, Z
	retlw 0

	; TODO: IF ALREADY TURNING (IN SAME DIRECTION) THEN RETURN 1.
	.setBankFor motorState
	#if (MOTOR_FLAG_DIRECTION_CLOCKWISE != 7)
		error "Expected MOTOR_FLAG_DIRECTION_CLOCKWISE to be bit 7 for easy retrieval"
	#endif
	rlf motorFlags, W

ifAlreadyTurningThenInitialStateIsForReversal:
	movlw MOTOR_STATE_TURNING
	xorwf motorState, W
	btfsc STATUS, Z
	goto reverseMotor

startMotor:
	.setBankFor PSTRCON
	btfsc STATUS, C
	bsf PSTRCON, STRA
	btfss STATUS, C
	bsf PSTRCON, STRB

	movlw MOTOR_STATE_SOFTSTART
	goto setStatesAndReturn

reverseMotor:
	.knownBank motorState
	bcf motorFlags, MOTOR_FLAG_REVERSE_IS_CLOCKWISE
	btfsc STATUS, C
	bsf motorFlags, MOTOR_FLAG_REVERSE_IS_CLOCKWISE
	movlw MOTOR_STATE_REVERSE

setStatesAndReturn:
	.safelySetBankFor motorState
	movwf motorState
	movlw MOTOR_STATE_TURNING
	movwf motorStateAfterStarted
	retlw 1

isMotorFullyTurning:
	.safelySetBankFor motorState
	movf motorState, W
	xorlw MOTOR_STATE_TURNING
	btfsc STATUS, Z
	retlw 1
	retlw 0


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
