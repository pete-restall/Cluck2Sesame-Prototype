	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_DUTY_CYCLE_INCREMENTS equ 40
DUTY_CYCLE_INCREMENT equ 6

	defineMotorState MOTOR_STATE_SOFTSTART
		banksel CCPR1L
		movlw DUTY_CYCLE_INCREMENT
		movwf CCPR1L

		banksel motorCounter
		movlw NUMBER_OF_DUTY_CYCLE_INCREMENTS
		movwf motorCounter

		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTART2
		returnFromMotorState


	defineMotorStateInSameSection MOTOR_STATE_SOFTSTART2
		banksel motorCounter
		decfsz motorCounter
		goto increaseDutyCycle

softStartFinished:
		movf motorStateAfterStarted, W
		movwf motorState

		banksel CCPR1L
		movlw 0xff
		movwf CCPR1L
		returnFromMotorState

increaseDutyCycle:
		banksel CCPR1L
		movlw DUTY_CYCLE_INCREMENT
		addwf CCPR1L

waitForAnother25ms:
		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTART2
		returnFromMotorState

	end
