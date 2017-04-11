	#include "Platform.inc"

	radix decimal

Timer0Ram udata
	global slowTmr0

slowTmr0 res 1

Timer0Dummies code
	global pollTimer0

pollTimer0:
	return

	end
