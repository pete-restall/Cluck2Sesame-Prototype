	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_SUNRISESUNSET

SunriseSunset code
	global pollSunriseSunset

pollSunriseSunset:
	tcall POLL_AFTER_SUNRISESUNSET

	end
