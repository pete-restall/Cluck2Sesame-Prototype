	#ifndef __CLUCK2SESAME_DOOR_DOOR_INC
	#define __CLUCK2SESAME_DOOR_DOOR_INC
	#include "Platform.inc"

	radix decimal

DOOR_FLAG_INITIALISED equ 0
DOOR_FLAG_OPENED equ 1
DOOR_FLAG_CLOSED equ 2

	.module DOOR

	.externalVariable doorFlags
	.externalVariable doorTodayBcd

	.externalVariable doorOperationStartedTimestamp
	.externalVariable doorTurnStartedTimestamp
	.externalVariable doorTurnFullSpeedTimestamp

	#endif
