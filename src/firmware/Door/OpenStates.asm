	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

NUMBER_OF_TICKS_0_5S equ 2
NUMBER_OF_TICKS_3S equ 12

	defineDoorState DOOR_STATE_OPEN
		bcf doorFlags, DOOR_FLAG_PREVIOUSJAM

		setDoorState DOOR_STATE_MOTORVDD_ENABLE
		setDoorNextState DOOR_STATE_OPEN_MOTORVDDENABLED
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_OPEN_MOTORVDDENABLED
		storeSlowTimer0 doorOperationStartedTimestamp

startRaising:
		.unknownBank
		setDoorState DOOR_STATE_MOTOR_STARTRAISING
		setDoorNextState DOOR_STATE_OPEN_RAISING
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_OPEN_RAISING
		; TODO: NO LOAD - FAULT
		; TODO: TIMEOUT - FAULT
		.setBankFor motorFlags
		btfss motorFlags, MOTOR_FLAG_OVERLOAD
		returnFromDoorState

motorJammed:
		.setBankFor doorFlags
		btfss doorFlags, DOOR_FLAG_PREVIOUSJAM
		goto lowerAndThenTryRaisingAgain

motorJammedAgain:
		elapsedSinceSlowTimer0 doorTurnFullSpeedTimestamp
		sublw NUMBER_OF_TICKS_3S
		btfss STATUS, C
		goto lowerAndThenTryRaisingAgain

motorJammedTwicedWithinShortTimeOfStarting:
		setDoorState DOOR_STATE_MOTOR_DONE
		setDoorNextState DOOR_STATE_OPENED
		returnFromDoorState

lowerAndThenTryRaisingAgain:
		.safelySetBankFor doorFlags
		bsf doorFlags, DOOR_FLAG_PREVIOUSJAM
		setDoorState DOOR_STATE_MOTOR_STARTLOWERING
		setDoorNextState DOOR_STATE_OPEN_LOWERING
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_OPEN_LOWERING
		; TODO: TIMEOUT - FAULT
		elapsedSinceSlowTimer0 doorTurnFullSpeedTimestamp
		sublw NUMBER_OF_TICKS_0_5S
		btfsc STATUS, C
		returnFromDoorState
		goto startRaising


	defineDoorStateInSameSection DOOR_STATE_OPENED
		bsf doorFlags, DOOR_FLAG_OPENED
		bcf doorFlags, DOOR_FLAG_CLOSED
		bcf doorFlags, DOOR_FLAG_PREVIOUSJAM
		setDoorState DOOR_STATE_WAIT_SUNSET
		returnFromDoorState

	end
