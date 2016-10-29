	#include "p16f685.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

PollAfterLcdDummy code
	global POLL_AFTER_LCD

POLL_AFTER_LCD:
	return

	end
