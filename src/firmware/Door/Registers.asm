	#include "Platform.inc"

	radix decimal

DoorRam udata
	global doorFlags

	global doorState
	global doorNextState

	global doorTodayBcd

doorFlags res 1

doorState res 1
doorNextState res 1

doorTodayBcd res 1

	end
