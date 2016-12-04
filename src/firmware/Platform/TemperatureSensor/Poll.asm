	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_TEMPERATURESENSOR

TemperatureSensor code
	global pollTemperatureSensor

pollTemperatureSensor:
	tcall POLL_AFTER_TEMPERATURESENSOR

	end
