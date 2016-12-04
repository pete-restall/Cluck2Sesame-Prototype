	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "PollChain.inc"
	#include "TestFixture.inc"

	radix decimal

	extern pollForWork
	extern POLL_FIRST

	global pollForWorkAddressHigh
	global pollForWorkAddressLow
	global pollFirstAddressHigh
	global pollFirstAddressLow

	udata
pollForWorkAddressHigh res 1
pollForWorkAddressLow res 1
pollFirstAddressHigh res 1
pollFirstAddressLow res 1

FirstPollInChainTest code
	global testArrange

testArrange:
storePollForWorkAddressHigh:
	banksel pollForWorkAddressHigh
	movlw high(pollForWork)
	movwf pollForWorkAddressHigh

storePollForWorkAddressLow:
	banksel pollForWorkAddressLow
	movlw low(pollForWork)
	movwf pollForWorkAddressLow

storePollFirstAddressHigh:
	banksel pollFirstAddressHigh
	movlw high(POLL_FIRST)
	movwf pollFirstAddressHigh

storePollFirstAddressLow:
	banksel pollFirstAddressLow
	movlw low(POLL_FIRST)
	movwf pollFirstAddressLow

testAct:
	pagesel testArrange

testAssert:
	.assert "pollForWorkAddressHigh == pollFirstAddressHigh, 'Expected first poll in chain to be POLL_FIRST.'"
	.assert "pollForWorkAddressLow == pollFirstAddressLow, 'Expected first poll in chain to be POLL_FIRST.'"
	return

	end
