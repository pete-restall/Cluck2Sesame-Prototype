	#include "p16f685.inc"

	radix decimal

	udata
	global mockCallCounter

mockCallCounter res 1

TestDoubles code
	global initialiseTestDoubles

initialiseTestDoubles:
	banksel mockCallCounter
	clrf mockCallCounter
	return

	end
