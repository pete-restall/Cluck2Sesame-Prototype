	#include "Platform.inc"
	#include "Clock.inc"
	#include "SunriseSunset.inc"
	#include "Door.inc"
	#include "States.inc"

	radix decimal

	defineDoorState DOOR_STATE_BEFORE_SUNRISE
		movlw DOOR_STATE_WAIT_SUNRISE
		btfss doorFlags, DOOR_FLAG_CLOSED
		movlw DOOR_STATE_CLOSE
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_WAIT_SUNRISE
		bankisel sunriseHourBcd
		movlw sunriseHourBcd
		movwf FSR
		call isCurrentTimeOnOrAfterIndf
		xorlw 0

		.knownBank clockHourBcd
		movlw DOOR_STATE_AFTER_SUNRISE
		btfsc STATUS, Z
		movlw DOOR_STATE_BEFORE_SUNRISE

		.setBankFor doorState
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_AFTER_SUNRISE
	defineDoorStateInSameSection DOOR_STATE_WAIT_SUNSET
		bankisel sunsetHourBcd
		movlw sunsetHourBcd
		movwf FSR
		call isCurrentTimeOnOrAfterIndf
		xorlw 0

		.knownBank clockHourBcd
		movlw DOOR_STATE_AFTER_SUNSET
		btfsc STATUS, Z
		movlw DOOR_STATE_BEFORE_SUNSET

		.setBankFor doorState
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_BEFORE_SUNSET
		movlw DOOR_STATE_WAIT_SUNSET
		btfss doorFlags, DOOR_FLAG_OPENED
		movlw DOOR_STATE_OPEN
		movwf doorState
		returnFromDoorState


	defineDoorStateInSameSection DOOR_STATE_AFTER_SUNSET
		movlw DOOR_STATE_WAIT_NEWDAY
		btfss doorFlags, DOOR_FLAG_CLOSED
		movlw DOOR_STATE_CLOSE
		movwf doorState
		returnFromDoorState


isCurrentTimeOnOrAfterIndf:
	.unknownBank
	movf INDF, W
	incf FSR

checkIfHourIsGreaterThanOrEqualToIndf:
	.setBankFor clockHourBcd
	subwf clockHourBcd, W
	btfss STATUS, C
	retlw 0 ; Current hour < *INDF
	btfss STATUS, Z
	retlw 1 ; Current hour > *INDF

hourIsEqualToIndfSoCheckMinutes:
	movf INDF, W
	subwf clockMinuteBcd, W
	btfss STATUS, C
	retlw 0 ; Current hour == *INDF && current minute < *(INDF + 1)
	retlw 1 ; Current hour == *INDF && current minute >= *(INDF + 1)

	end
