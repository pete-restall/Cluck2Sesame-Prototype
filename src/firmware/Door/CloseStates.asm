	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

NUMBER_OF_TICKS_0_5S equ 2
NUMBER_OF_TICKS_5S equ 19
NUMBER_OF_TICKS_6S equ 23

	defineDoorState DOOR_STATE_CLOSE
		setDoorState DOOR_STATE_MOTORVDD_ENABLE
		setDoorNextState DOOR_STATE_CLOSE_MOTORVDDENABLED
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_CLOSE_MOTORVDDENABLED
		storeSlowTimer0 doorOperationStartedTimestamp

startLowering:
		.unknownBank
		setDoorState DOOR_STATE_MOTOR_STARTLOWERING
		setDoorNextState DOOR_STATE_CLOSE_LOWERING
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_CLOSE_LOWERING
		; TODO: OVERLOAD - FAULT
		; TODO: TIMEOUT - FAULT
		elapsedSinceSlowTimer0 doorTurnFullSpeedTimestamp
		sublw NUMBER_OF_TICKS_5S
		btfsc STATUS, C
		returnFromDoorState

rewindToTestMotorLoad:
		setDoorState DOOR_STATE_MOTOR_STARTRAISING
		setDoorNextState DOOR_STATE_CLOSE_RAISING
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_CLOSE_RAISING
		; TODO: OVERLOAD - FAULT
		; TODO: TIMEOUT - FAULT
		elapsedSinceSlowTimer0 doorTurnFullSpeedTimestamp
		sublw NUMBER_OF_TICKS_0_5S
		btfsc STATUS, C
		returnFromDoorState

ifMotorLoadPresentThenMoreLoweringIsRequired:
		.setBankFor motorFlags
		btfss motorFlags, MOTOR_FLAG_NOLOAD
		goto startLowering

loweredTooFar:
		bsf motorFlags, MOTOR_FLAG_PREVENT_NOMINALLOAD
		setDoorState DOOR_STATE_CLOSE_WAITFORISRSTOP
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_CLOSE_WAITFORISRSTOP
		.setBankFor PSTRCON
		movlw MOTOR_PSTRCON_OUTPUT_MASK
		andwf PSTRCON, W
		btfsc STATUS, Z
		goto motorStoppedByIsr

motorShouldNotRaiseMuchMoreThanItLowered:
		elapsedSinceSlowTimer0 doorTurnFullSpeedTimestamp
		sublw NUMBER_OF_TICKS_6S
		btfsc STATUS, C
		returnFromDoorState

		; TODO: TIMED OUT WHILE WAITING FOR LOAD TO BITE - FAULT

motorStoppedByIsr:
		.safelySetBankFor motorFlags
		bcf motorFlags, MOTOR_FLAG_PREVENT_NOMINALLOAD
		setDoorState DOOR_STATE_CLOSED
		fcall stopMotor
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_CLOSED
		bsf doorFlags, DOOR_FLAG_CLOSED
		bcf doorFlags, DOOR_FLAG_OPENED
		setDoorState DOOR_STATE_WAIT_NEWDAY

		fcall disableMotorVdd
		returnFromDoorState

	end
