	#include "p16f685.inc"
	#include "TestFixture.inc"
	radix decimal

AssertNoIsr code 0x0004
	.assert "false, \"ISR should not be called during this test.\""
	retfie

	end
