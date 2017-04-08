	#include "Platform.inc"
	#include "PowerManagement.inc"

	radix decimal

PowerManagement code
	global preventSleep

preventSleep:
	.safelySetBankFor powerManagementFlags
	bsf powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	return

	end
