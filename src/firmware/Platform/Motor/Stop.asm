	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

Motor code
	global stopMotor

stopMotor:
	; TODO: IF MOTOR ALREADY STOPPED (IE. PSTRCON & STR{A,B} == 0), DON'T
	; BOTHER TRYING TO SOFT-STOP...

	.safelySetBankFor motorStateAfterStopped
	movlw MOTOR_STATE_STOPPED
	movwf motorStateAfterStopped

	setMotorState MOTOR_STATE_SOFTSTOP
	return


	defineMotorStateInSameSection MOTOR_STATE_STOPPED
		setMotorState MOTOR_STATE_IDLE

		.setBankFor MOTOR_PORT
		movlw ~(MOTOR_PWMA_PIN_MASK | MOTOR_PWMB_PIN_MASK)
		andwf MOTOR_PORT

		.setBankFor PSTRCON
		movlw ~MOTOR_PSTRCON_OUTPUT_MASK
		andwf PSTRCON

		fcall releaseAdcChannel
		returnFromMotorState

	end
