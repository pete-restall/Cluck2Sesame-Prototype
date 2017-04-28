	#include "Platform.inc"

	radix decimal

DoorRam udata
	global doorFlags

	global doorState
	global doorNextState

	global doorTodayBcd

	global doorOperationStartedTimestamp
	global doorTurnStartedTimestamp
	global doorTurnFullSpeedTimestamp

doorFlags res 1

doorState res 1
doorNextState res 1

doorTodayBcd res 1

doorOperationStartedTimestamp res 1
doorTurnStartedTimestamp res 1
doorTurnFullSpeedTimestamp res 1

	end
