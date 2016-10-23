	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_TEMPERATURESENSOR

TemperatureSensor code
	global initialiseTemperatureSensor

initialiseTemperatureSensor:
	tcall INITIALISE_AFTER_TEMPERATURESENSOR

	end
