	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledSetAdcChannel
	global calledReleaseAdcChannel

calledSetAdcChannel res 1
calledReleaseAdcChannel res 1
setAdcChannelResult res 1

ChannelMocks code
	global initialiseSetAdcChannelMock
	global initialiseReleaseAdcChannelMock
	global setAdcChannel
	global releaseAdcChannel

initialiseSetAdcChannelMock:
	banksel setAdcChannelResult
	movwf setAdcChannelResult
	clrf calledSetAdcChannel
	return

initialiseReleaseAdcChannelMock:
	banksel calledReleaseAdcChannel
	clrf calledReleaseAdcChannel
	return

setAdcChannel:
	mockCalled calledSetAdcChannel
	banksel setAdcChannelResult
	movf setAdcChannelResult, W
	return

releaseAdcChannel:
	mockCalled calledReleaseAdcChannel
	return

	end
