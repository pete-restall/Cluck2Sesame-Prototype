	#define __CLUCK2SESAME_PLATFORM_MOTOR_POLL_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_MOTOR

Motor code
	global pollMotor
	global pollNextInChainAfterMotor

pollMotor:
	.unknownBank
	tableDefinitionToJumpWith motorState
	createMotorStateTable

pollNextInChainAfterMotor:
	tcall POLL_AFTER_MOTOR

	end
