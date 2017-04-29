	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "PowerManagement.inc"
	#include "Motor.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	defineDoorState DOOR_STATE_MOTOR_STARTRAISING
		fcall turnMotorClockwise
		goto afterCallToTurn

	defineDoorStateInSameSection DOOR_STATE_MOTOR_STARTLOWERING
		fcall turnMotorAntiClockwise

afterCallToTurn:
		.unknownBank
		xorlw 0
		btfsc STATUS, Z
		returnFromDoorState

		storeSlowTimer0 doorTurnStartedTimestamp
		setDoorState DOOR_STATE_MOTOR_WAITFULLYTURNING
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_MOTOR_WAITFULLYTURNING
		fcall isMotorFullyTurning
		xorlw 0
		btfsc STATUS, Z
		returnFromDoorState

		storeSlowTimer0 doorTurnFullSpeedTimestamp

		.setBankFor doorNextState
		movf doorNextState, W
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_MOTOR_DONE
		fcall stopMotor
		setDoorState DOOR_STATE_MOTOR_WAITSTOP
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_MOTOR_WAITSTOP
		.setBankFor CCPR1L
		movf CCPR1L
		btfss STATUS, Z
		returnFromDoorState

		.setBankFor doorNextState
		movf doorNextState, W
		movwf doorState

		fcall disableMotorVdd
		fcall preventSleep
		returnFromDoorState

	end
