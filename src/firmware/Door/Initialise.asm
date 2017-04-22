	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_DOOR

Door code
	global initialiseDoor

initialiseDoor:
	.safelySetBankFor doorFlags
	clrf doorFlags
	clrf doorState
	tcall INITIALISE_AFTER_DOOR


	defineDoorStateInSameSection DOOR_STATE_UNINITIALISED
		btfss doorFlags, DOOR_FLAG_INITIALISED
		returnFromDoorState

		movlw DOOR_STATE_NEWDAY
		movwf doorState
		returnFromDoorState

	end
