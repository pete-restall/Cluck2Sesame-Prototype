	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "SunriseSunset.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	defineDoorState DOOR_STATE_WAIT_NEWDAY
		movf doorTodayBcd, W
		.setBankFor clockDayBcd
		xorwf clockDayBcd, W
		btfsc STATUS, Z
		returnFromDoorState

		movlw DOOR_STATE_NEWDAY
		.setBankFor doorState
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_NEWDAY
		fcall calculateSunriseAndSunset

		.setBankFor clockDayBcd
		movf clockDayBcd, W
		.setBankFor doorTodayBcd
		movwf doorTodayBcd

		setDoorState DOOR_STATE_NEWDAY_WAITFORSUNEVENTCALCULATIONS		
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_NEWDAY_WAITFORSUNEVENTCALCULATIONS
		fcall areSunriseAndSunsetValid
		xorlw 0
		btfsc STATUS, Z
		returnFromDoorState

		setDoorState DOOR_STATE_WAIT_SUNRISE
		returnFromDoorState

	end
