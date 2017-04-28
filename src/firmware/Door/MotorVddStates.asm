	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	defineDoorState DOOR_STATE_MOTORVDD_ENABLE
		fcall enableMotorVdd
		setDoorState DOOR_STATE_MOTORVDD_WAITENABLED
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_MOTORVDD_WAITENABLED
		fcall isMotorVddEnabled
		xorlw 0
		.setBankFor doorNextState
		movlw DOOR_STATE_MOTORVDD_WAITENABLED
		btfss STATUS, Z
		movf doorNextState, W
		movwf doorState
		returnFromDoorState

	end
