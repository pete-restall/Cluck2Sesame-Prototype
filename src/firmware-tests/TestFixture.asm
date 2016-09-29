	#include "p16f685.inc"
	radix decimal

	extern testArrange

boot code 0x0000
	pagesel testArrange
	goto testArrange

	end
