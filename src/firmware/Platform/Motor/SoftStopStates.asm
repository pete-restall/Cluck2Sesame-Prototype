	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_DUTY_CYCLE_DECREMENTS equ 40
DUTY_CYCLE_DECREMENT equ 6

	defineMotorState MOTOR_STATE_SOFTSTOP
		banksel CCPR1L
		movlw DUTY_CYCLE_DECREMENT * NUMBER_OF_DUTY_CYCLE_DECREMENTS
		movwf CCPR1L

		banksel motorCounter
		movlw NUMBER_OF_DUTY_CYCLE_DECREMENTS
		movwf motorCounter

		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTOP2
		returnFromMotorState


	defineMotorStateInSameSection MOTOR_STATE_SOFTSTOP2
		banksel motorCounter
		decfsz motorCounter
		goto decreaseDutyCycle

softStopFinished:
		movf motorStateAfterStopped, W
		movwf motorState

		banksel CCPR1L
		clrf CCPR1L
		returnFromMotorState

decreaseDutyCycle:
		banksel CCPR1L
		movlw DUTY_CYCLE_DECREMENT
		subwf CCPR1L

waitForAnother25ms:
		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTOP2
		returnFromMotorState

	end
