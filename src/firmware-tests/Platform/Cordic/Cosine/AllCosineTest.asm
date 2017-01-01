	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"

	radix decimal

AllCosineTest code
	global cordicCall

cordicCall:
	fcall cosine
	return

	end
