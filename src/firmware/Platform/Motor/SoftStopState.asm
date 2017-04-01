	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

DUTY_CYCLE_DECREMENT equ 6

	defineMotorState MOTOR_STATE_SOFTSTOP
decreaseDutyCycle:
		banksel CCPR1L
		movlw DUTY_CYCLE_DECREMENT
		subwf CCPR1L, W
		btfss STATUS, C
		goto softStopFinished
		movwf CCPR1L

waitBeforeDecreasingDutyCycleAgain:
		setMotorWaitState NUMBER_OF_TICKS_SOFTSTOP, MOTOR_STATE_SOFTSTOP
		returnFromMotorState

softStopFinished:
		clrf CCPR1L

		; TODO: RELEASE THE ADC CHANNEL...

		banksel motorStateAfterStopped
		movf motorStateAfterStopped, W
		movwf motorState
		returnFromMotorState

	end
