	#include "Platform.inc"

	radix decimal

ButtonsRam udata
	global buttonFlags
	global buttonLastCheckTimestamp
	global buttonSnapshot
	global button1State
	global button2State

buttonFlags res 1
buttonLastCheckTimestamp res 1
buttonSnapshot res 1
button1State res 1
button2State res 1

	end
