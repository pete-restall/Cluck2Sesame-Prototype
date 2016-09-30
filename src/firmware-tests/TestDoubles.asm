	#include "p16f685.inc"
	radix decimal

	global spyCallCounter
	global initialiseTestDoubles

	udata
spyCallCounter res 1

	code
initialiseTestDoubles:
	banksel spyCallCounter
	clrf spyCallCounter
	return

	end
