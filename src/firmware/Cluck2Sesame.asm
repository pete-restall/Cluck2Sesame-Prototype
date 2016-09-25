	#include "p16f685.inc"
	radix decimal

boot code 0x0000
	extern main
	goto main
	nop
	nop
	nop

	end
