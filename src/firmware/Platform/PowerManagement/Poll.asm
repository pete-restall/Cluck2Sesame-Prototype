	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "PowerManagement.inc"

	radix decimal

PowerManagement code
	global pollPowerManagement

pollPowerManagement:
doNotSleepIfAdcIsRunning:
	.safelySetBankFor ADCON0
	btfsc ADCON0, ADON
	goto returnFromPoll

doNotSleepIfTimer2IsRunning:
	.setBankFor T2CON
	btfsc T2CON, TMR2ON
	goto returnFromPoll

doNotSleepIfPrevented:
	.setBankFor powerManagementFlags
	btfss powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	sleep

returnFromPoll:
	.safelySetBankFor powerManagementFlags
	bcf powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	return

	end
