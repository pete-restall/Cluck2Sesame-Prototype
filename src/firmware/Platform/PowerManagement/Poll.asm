	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "PowerManagement.inc"

	radix decimal

PowerManagement code
	global pollPowerManagement

pollPowerManagement:
doNotSleepIfAdcIsRunning:
	banksel ADCON0
	btfsc ADCON0, ADON
	goto returnFromPoll

doNotSleepIfTimer2IsRunning:
	banksel T2CON
	btfsc T2CON, TMR2ON
	goto returnFromPoll

doNotSleepIfPrevented:
	banksel powerManagementFlags
	btfsc powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	goto returnFromPoll

nothingIsPreventingSleep:
	sleep

returnFromPoll:
	banksel powerManagementFlags
	bcf powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	return

	end