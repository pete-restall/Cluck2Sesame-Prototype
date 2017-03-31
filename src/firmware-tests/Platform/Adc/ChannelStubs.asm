	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
setAdcChannelResult res 1

ChannelStubs code
	global initialiseSetAdcChannelStub
	global setAdcChannel
	global releaseAdcChannel

initialiseSetAdcChannelStub:
	banksel setAdcChannelResult
	movwf setAdcChannelResult
	return

setAdcChannel:
	banksel setAdcChannelResult
	movf setAdcChannelResult, W
	return

releaseAdcChannel:
	return

	end
