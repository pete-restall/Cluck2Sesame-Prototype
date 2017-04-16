	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"

	radix decimal

EnableDisableSmpsTest code
	global doEnableCall
	global doDisableCall

doEnableCall:
	fcall enableSmps
	return

doDisableCall:
	fcall disableSmps
	return

	end
