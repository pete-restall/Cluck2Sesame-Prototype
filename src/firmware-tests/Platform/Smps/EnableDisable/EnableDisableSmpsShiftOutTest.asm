	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"

	radix decimal

EnableDisableSmpsShiftOutTest code
	global doEnableCall
	global doDisableCall

doEnableCall:
	fcall enableSmps
	return

doDisableCall:
	fcall enableSmps
	return

	end
