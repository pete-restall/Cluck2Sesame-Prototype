	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"

	radix decimal

EnableDisableSmpsHighPowerModeRmwTest code
	global doEnableCall
	global doDisableCall

doEnableCall:
	fcall enableSmpsHighPowerMode
	return

doDisableCall:
	fcall disableSmpsHighPowerMode
	return

	end
