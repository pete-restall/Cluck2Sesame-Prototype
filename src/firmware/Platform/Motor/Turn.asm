	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "Adc.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise
	global turnMotorAntiClockwise

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
	movf motorState, W
	xorlw MOTOR_STATE_TURNING
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
ifAlreadyTurningThenInitialStateIsForReversal:
	.setBankFor PSTRCON
	movlw (1 << STRA) | (1 << STRB)
	andwf PSTRCON, W
	btfss STATUS, Z
	goto reverseMotor

startMotor:
	.setBankFor motorFlags
	#if (MOTOR_FLAG_DIRECTION_CLOCKWISE != 7)
		error "Expected MOTOR_FLAG_DIRECTION_CLOCKWISE to be bit 7 for easy retrieval"
	#endif
	rlf motorFlags, W

	.setBankFor PSTRCON
	btfsc STATUS, C
	bsf PSTRCON, STRA
	btfss STATUS, C
	bsf PSTRCON, STRB

	movlw MOTOR_STATE_SOFTSTART
	goto setStatesAndReturn

reverseMotor:
	movlw MOTOR_STATE_REVERSE

setStatesAndReturn:
	.safelySetBankFor motorState
	movwf motorState
	movlw MOTOR_STATE_TURNING
	movwf motorStateAfterStarted
	retlw 1


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
