	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "Motor.inc"

	radix decimal

	extern POLL_AFTER_MOTOR

Motor code
	global pollMotor

pollMotor:
	tcall POLL_AFTER_MOTOR

	end
