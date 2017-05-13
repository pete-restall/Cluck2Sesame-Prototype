	#include "Platform.inc"

	radix decimal

Timer0Ram udata
	global slowTmr0
	global tmr0Overflow

slowTmr0 res 1
tmr0Overflow res 1

Timer0Dummies code
	global initialiseTimer0
	global pollTimer0

initialiseTimer0:
pollTimer0:
	return

	end
