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
		setMotorWaitState NUMBER_OF_TICKS_10MS, MOTOR_STATE_SOFTSTART

		.setBankFor MOTOR_PORT
		bcf MOTOR_PORT, MOTOR_PWMA_PIN
		bcf MOTOR_PORT, MOTOR_PWMB_PIN

		.setBankFor motorFlags
		movlw (1 << STRSYNC) | (1 << STRA)
		btfss motorFlags, MOTOR_FLAG_REVERSE_IS_CLOCKWISE
		movlw (1 << STRSYNC) | (1 << STRB)

		.setBankFor PSTRCON
		andwf PSTRCON
		iorwf PSTRCON

		returnFromMotorState

	end
