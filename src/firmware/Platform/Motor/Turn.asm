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
	bsf STATUS, C
	goto ensureMotorIsInSteadyState

turnMotorAntiClockwise:
	bcf STATUS, C

ensureMotorIsInSteadyState:
checkIfMotorIsInIdleState:
	.safelySetBankFor motorState
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
	.setBankFor CCPR1L
	movf CCPR1L
	btfss STATUS, Z
	goto reverseMotor

startMotor:
	.safelySetBankFor PSTRCON
	btfsc STATUS, C
	bsf PSTRCON, STRA
	btfss STATUS, C
	bsf PSTRCON, STRB

	.setBankFor motorState
	movlw MOTOR_STATE_SOFTSTART
	goto setStatesAndReturn

reverseMotor:
	.setBankFor motorState
	movlw MOTOR_STATE_REVERSE

setStatesAndReturn:
	movwf motorState
	movlw MOTOR_STATE_TURNING
	movwf motorStateAfterStarted
	retlw 1


	defineMotorStateInSameSection MOTOR_STATE_TURNING
	returnFromMotorState

	end
