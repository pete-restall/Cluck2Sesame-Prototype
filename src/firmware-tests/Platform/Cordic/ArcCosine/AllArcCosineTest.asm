	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"

	radix decimal

AllArcCosineTest code
	global cordicCall

cordicCall:
	fcall arcCosine
	return

	end
