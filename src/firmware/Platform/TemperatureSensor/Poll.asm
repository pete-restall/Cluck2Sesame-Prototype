	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_TEMPERATURESENSOR

TemperatureSensor code
	global pollTemperatureSensor

pollTemperatureSensor:
	.unknownBank
	tcall POLL_AFTER_TEMPERATURESENSOR

	end
