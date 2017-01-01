	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"

	radix decimal

AllArcSineTest code
	global cordicCall

cordicCall:
	fcall arcSine
	return

	end
