	#include "p16f685.inc"
	radix decimal

	extern main

boot code 0x0000
	pagesel main
	goto main

	end
