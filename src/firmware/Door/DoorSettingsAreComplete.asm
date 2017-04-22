	#include "Platform.inc"
	#include "Door.inc"

	radix decimal

Door code
	global doorSettingsAreComplete

doorSettingsAreComplete:
	.safelySetBankFor doorFlags
	bsf doorFlags, DOOR_FLAG_INITIALISED
	return

	end
