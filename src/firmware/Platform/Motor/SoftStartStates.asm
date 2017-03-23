	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_TICKS_25MS equ 196
NUMBER_OF_DUTY_CYCLE_INCREMENTS equ 5
DUTY_CYCLE_INCREMENT equ 25

	defineMotorState MOTOR_STATE_SOFTSTART
		banksel CCPR1L
		movlw DUTY_CYCLE_INCREMENT
		movwf CCPR1L

		banksel motorCounter
		movlw 4 * NUMBER_OF_DUTY_CYCLE_INCREMENTS
		movwf motorCounter
		
		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTART2
		returnFromMotorState


	defineMotorStateInSameSection MOTOR_STATE_SOFTSTART2
		banksel motorCounter
		decfsz motorCounter
		goto incrementDutyCycleIfCounterIsMultipleOfFour

softStartFinished:
		banksel CCPR1L
		movlw 0xff
		movwf CCPR1L
		setMotorState MOTOR_STATE_IDLE
		returnFromMotorState

incrementDutyCycleIfCounterIsMultipleOfFour:
		movlw 3
		andwf motorCounter, W
		movlw 0
		btfsc STATUS, Z
		movlw DUTY_CYCLE_INCREMENT

		banksel CCPR1L
		addwf CCPR1L

waitForAnother25ms:
		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTART2
		returnFromMotorState

	end
