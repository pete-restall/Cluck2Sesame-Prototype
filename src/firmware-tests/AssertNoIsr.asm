	#include "p16f685.inc"
	#include "coff.inc"
	radix decimal

isr code 0x0004
	.assert "1 == 0, \"ISR should not be called during this test.\""
	retfie

	end
