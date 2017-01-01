	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"

	radix decimal

AllSineTest code
	global cordicCall

cordicCall:
	fcall sine
	return

	end
