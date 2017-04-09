	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

MOTOR_PSTRCON_OUTPUT_MASK equ ~(1 << STRSYNC)

Motor code
	global stopMotor

stopMotor:
	.safelySetBankFor motorStateAfterStopped
	movlw MOTOR_STATE_STOPPED
	movwf motorStateAfterStopped

	setMotorState MOTOR_STATE_SOFTSTOP
	return


	defineMotorStateInSameSection MOTOR_STATE_STOPPED
		.setBankFor PSTRCON
		movlw ~MOTOR_PSTRCON_OUTPUT_MASK
		andwf PSTRCON

		.setBankFor MOTOR_PORT
		movlw ~(MOTOR_PWMA_PIN_MASK | MOTOR_PWMB_PIN_MASK)
		andwf MOTOR_PORT

		setMotorState MOTOR_STATE_IDLE

		fcall releaseAdcChannel
		returnFromMotorState

	end
