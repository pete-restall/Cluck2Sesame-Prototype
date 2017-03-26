	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_STATES_INC
	#define __CLUCK2SESAME_PLATFORM_MOTOR_STATES_INC

	radix decimal

MOTOR_STATE_DISABLED equ 0x00
MOTOR_STATE_IDLE equ 0x01
MOTOR_STATE_WAIT equ 0x02
MOTOR_STATE_SOFTSTART equ 0x03
MOTOR_STATE_SOFTSTART2 equ 0x04
MOTOR_STATE_SOFTSTOP equ 0x05
MOTOR_STATE_SOFTSTOP2 equ 0x06
MOTOR_STATE_TURNING equ 0x07
MOTOR_STATE_REVERSE equ 0x08
MOTOR_STATE_REVERSE2 equ 0x09

MOTOR_STATE_LAST equ MOTOR_STATE_REVERSE2

	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_REGISTERS_ASM
	extern motorState
	extern motorNextState
	extern motorStateParameter0
	extern motorStateParameter1
	extern motorStateAfterStarted
	extern motorStateAfterStopped
	#endif

	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_POLL_ASM
	extern pollNextInChainAfterMotor
	#endif

setMotorState macro state
	banksel motorState
	movlw state
	movwf motorState
	endm

setMotorNextState macro state
	banksel motorNextState
	movlw state
	movwf motorNextState
	endm

defineMotorStateInSameSection macro name
	global motorState#v(name)

motorState#v(name):
	endm

defineMotorState macro name
Motor code
	defineMotorStateInSameSection name
	endm

defineMotorStateTableEntry macro i
	if (i <= MOTOR_STATE_LAST)
		extern motorState#v(i)
		goto motorState#v(i)
		defineMotorStateTableEntry i + 1
	endif
	endm

createMotorStateTable macro
	defineMotorStateTableEntry 0
	endm

returnFromMotorState macro
	goto pollNextInChainAfterMotor
	endm

	#endif