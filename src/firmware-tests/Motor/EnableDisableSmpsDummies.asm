	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

EnableDisableSmpsDummies code
	global enableSmps
	global disableSmps
	global isSmpsEnabled

enableSmps:
disableSmps:
isSmpsEnabled:
	return

	end
