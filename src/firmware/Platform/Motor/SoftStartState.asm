	#include "Platform.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

DUTY_CYCLE_INCREMENT equ 2

	defineMotorState MOTOR_STATE_SOFTSTART
increaseDutyCycle:
		.setBankFor CCPR1L
		movlw DUTY_CYCLE_INCREMENT
		addwf CCPR1L, W
		btfsc STATUS, C
		goto softStartFinished
		movwf CCPR1L

waitBeforeIncreasingDutyCycleAgain:
		setMotorWaitState NUMBER_OF_TICKS_SOFTSTART, MOTOR_STATE_SOFTSTART
		returnFromMotorState

softStartFinished:
		movlw 0xff
		movwf CCPR1L

		movf motorStateAfterStarted, W
		movwf motorState
		returnFromMotorState

	end
