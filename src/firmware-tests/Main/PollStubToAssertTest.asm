	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	radix decimal

	extern testAssert

	global pollTemperatureSensor

	code
pollTemperatureSensor:
	tcall testAssert

	end
