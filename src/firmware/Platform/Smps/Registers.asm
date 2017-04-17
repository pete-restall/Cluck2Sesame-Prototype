	#include "Platform.inc"

	radix decimal

SmpsRam udata
	global enableSmpsCount
	global enableSmpsHighPowerModeCount
	global smpsFlags
	global smpsEnabledTimestamp

enableSmpsCount res 1
enableSmpsHighPowerModeCount res 1
smpsFlags res 1
smpsEnabledTimestamp res 1

	end
