	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

	defineMotorState MOTOR_STATE_REVERSE
		banksel motorState
		movlw MOTOR_STATE_SOFTSTOP
		movwf motorState

		movlw MOTOR_STATE_REVERSE2
		movwf motorStateAfterStopped

		returnFromMotorState


	defineMotorStateInSameSection MOTOR_STATE_REVERSE2
		setMotorWaitState NUMBER_OF_TICKS_25MS, MOTOR_STATE_SOFTSTART
		returnFromMotorState

	end
