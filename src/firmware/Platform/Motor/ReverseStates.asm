	#include "Platform.inc"
	#include "Motor.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

	defineMotorState MOTOR_STATE_REVERSE
		.setBankFor motorState
		movlw MOTOR_STATE_SOFTSTOP
		movwf motorState

		movlw MOTOR_STATE_REVERSE2
		movwf motorStateAfterStopped

		returnFromMotorState


	defineMotorStateInSameSection MOTOR_STATE_REVERSE2
		.setBankFor PSTRCON
		movlw (1 << STRA) | (1 << STRB)
		xorwf PSTRCON

		setMotorWaitState NUMBER_OF_TICKS_10MS, MOTOR_STATE_SOFTSTART
		returnFromMotorState

	end
