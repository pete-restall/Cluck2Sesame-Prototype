	#define __CLUCK2SESAME_SUNRISESUNSET_POLL_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_SUNRISESUNSET

SunriseSunset code
	global pollSunriseSunset
	global pollNextInChainAfterSunriseSunset

pollSunriseSunset:
	.unknownBank
	tableDefinitionToJumpWith sunriseSunsetState
	createSunriseSunsetStateTable

pollNextInChainAfterSunriseSunset:
	tcall POLL_AFTER_SUNRISESUNSET

	end
