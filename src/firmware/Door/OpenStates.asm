	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	defineDoorState DOOR_STATE_OPEN
		setDoorState DOOR_STATE_MOTORVDD_ENABLE
		setDoorNextState DOOR_STATE_OPEN_MOTORVDDENABLED
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_OPEN_MOTORVDDENABLED
		; TODO: USE THE DOOR_STATE_MOTOR_STARTRAISING STATE...
		fcall turnMotorClockwise
		xorlw 0
		btfsc STATUS, Z
		returnFromDoorState

		; TODO: SET TIME, ETC...

		returnFromDoorState

	end
