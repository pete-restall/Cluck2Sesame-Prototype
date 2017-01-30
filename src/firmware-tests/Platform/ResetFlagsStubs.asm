	#include "Mcu.inc"
	#include "ResetFlags.inc"
	#include "TestDoubles.inc"

	radix decimal

	extern resetFlags

ResetFlagsStubs code
	global stubIsLastResetDueToBrownOutToReturnTrue
	global stubIsLastResetDueToBrownOutToReturnFalse

stubIsLastResetDueToBrownOutToReturnTrue:
	banksel resetFlags
	bsf resetFlags, RESET_FLAG_BROWNOUT
	return

stubIsLastResetDueToBrownOutToReturnFalse:
	banksel resetFlags
	bcf resetFlags, RESET_FLAG_BROWNOUT
	return

	end
