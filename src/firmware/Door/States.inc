	#ifndef __CLUCK2SESAME_DOOR_STATES_INC
	#define __CLUCK2SESAME_DOOR_STATES_INC
	#include "Platform.inc"

	radix decimal

	.module DOOR

DOOR_STATE_UNINITIALISED equ 0x00
DOOR_STATE_WAIT_NEWDAY equ 0x01
DOOR_STATE_NEWDAY equ 0x02
DOOR_STATE_NEWDAY_WAITFORSUNEVENTCALCULATIONS equ 0x03
DOOR_STATE_BEFORE_SUNRISE equ 0x04
DOOR_STATE_WAIT_SUNRISE equ 0x05
DOOR_STATE_AFTER_SUNRISE equ 0x06
DOOR_STATE_BEFORE_SUNSET equ 0x07
DOOR_STATE_WAIT_SUNSET equ 0x08
DOOR_STATE_AFTER_SUNSET equ 0x09
DOOR_STATE_OPEN equ 0x0a
DOOR_STATE_MOTORVDD_ENABLE equ 0x0b
DOOR_STATE_MOTORVDD_WAITENABLED equ 0x0c
DOOR_STATE_OPEN_MOTORVDDENABLED equ 0x0d
DOOR_STATE_MOTOR_STARTRAISING equ 0x0e
DOOR_STATE_MOTOR_STARTLOWERING equ 0x0f
DOOR_STATE_MOTOR_WAITFULLYTURNING equ 0x10
DOOR_STATE_CLOSE equ 0x11
DOOR_STATE_CLOSE_MOTORVDDENABLED equ 0x12
DOOR_STATE_CLOSE_LOWERING equ 0x13
DOOR_STATE_CLOSE_RAISING equ 0x14
DOOR_STATE_CLOSE_WAITFORISRSTOP equ 0x15
DOOR_STATE_CLOSED equ 0x16

DOOR_STATE_LAST equ DOOR_STATE_CLOSED

	.externalVariable doorState
	.externalVariable doorNextState

	#ifndef __CLUCK2SESAME_DOOR_POLL_ASM
	extern pollNextInChainAfterDoor
	#endif

setDoorState macro state
	.setBankFor doorState
	movlw state
	movwf doorState
	endm

setDoorNextState macro state
	.setBankFor doorNextState
	movlw state
	movwf doorNextState
	endm

defineDoorStateInSameSection macro name
	global doorState#v(name)

doorState#v(name):
	.knownBank doorState
	endm

defineDoorState macro name
Door code
	defineDoorStateInSameSection name
	endm

defineDoorStateTableEntry macro i
	if (i <= DOOR_STATE_LAST)
		extern doorState#v(i)
		goto doorState#v(i)
		defineDoorStateTableEntry i + 1
	endif
	endm

createDoorStateTable macro
	defineDoorStateTableEntry 0
	endm

returnFromDoorState macro
	goto pollNextInChainAfterDoor
	endm

	#endif
