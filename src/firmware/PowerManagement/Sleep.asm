	#include "p16f685.inc"
	#include "PowerManagement.inc"

	radix decimal

PowerManagement code
	global preventSleep

preventSleep:
	banksel powerManagementFlags
	bsf powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	return

	end
