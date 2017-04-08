	#include "Platform.inc"

	radix decimal

LcdRam udata
returnValue res 1

IsLcdIdleStub code
	global initialiseIsLcdIdleStub
	global isLcdIdle

initialiseIsLcdIdleStub:
	banksel returnValue
	movwf returnValue
	return

isLcdIdle:
	banksel returnValue
	movf returnValue, W
	return

	end
