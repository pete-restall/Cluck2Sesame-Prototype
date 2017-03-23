	#ifndef __CLUCK2SESAME_PLATFORM_MOTOR_WAITSTATE_INC
	#define __CLUCK2SESAME_PLATFORM_MOTOR_WAITSTATE_INC
	#include "States.inc"
	#include "Timer0.inc"

	radix decimal

	#define MOTOR_WAIT_PARAM_INITIAL_TICKS motorStateParameter0
	#define MOTOR_WAIT_PARAM_NUMBER_OF_TICKS motorStateParameter1

setMotorWaitStateWithUnmodifiedNextState macro numberOfTicks
	storeTimer0 MOTOR_WAIT_PARAM_INITIAL_TICKS
	movlw numberOfTicks
	movwf MOTOR_WAIT_PARAM_NUMBER_OF_TICKS

	setMotorState MOTOR_STATE_WAIT
	endm

setMotorWaitState macro numberOfTicks, nextState
	setMotorWaitStateWithUnmodifiedNextState numberOfTicks
	setMotorNextState nextState
	endm

	#endif
