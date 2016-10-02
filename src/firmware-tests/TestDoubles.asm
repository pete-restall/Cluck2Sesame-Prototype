	#include "p16f685.inc"
	radix decimal

	global mockCallCounter
	global initialiseTestDoubles

	udata
mockCallCounter res 1

	code
initialiseTestDoubles:
	banksel mockCallCounter
	clrf mockCallCounter
	return

	end
