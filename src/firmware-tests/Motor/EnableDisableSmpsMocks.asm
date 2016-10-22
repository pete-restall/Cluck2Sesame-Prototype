	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableSmpsCount
	global calledEnableSmpsTrisc
	global calledDisableSmpsCount
	global calledDisableSmpsTrisc

calledEnableSmpsCount res 1
calledEnableSmpsTrisc res 1
calledDisableSmpsCount res 1
calledDisableSmpsTrisc res 1

EnableDisableSmpsMocks code
	global initialiseEnableAndDisableSmpsMocks
	global enableSmps
	global disableSmps
	global isSmpsEnabled

initialiseEnableAndDisableSmpsMocks:
	banksel calledEnableSmpsCount
	clrf calledEnableSmpsCount
	clrf calledDisableSmpsCount
	return

enableSmps:
	mockIncrementCallCounter calledEnableSmpsCount

	banksel TRISC
	movf TRISC, W
	banksel calledEnableSmpsTrisc
	movwf calledEnableSmpsTrisc
	return

disableSmps:
	mockIncrementCallCounter calledDisableSmpsCount

	banksel TRISC
	movf TRISC, W
	banksel calledDisableSmpsTrisc
	movwf calledDisableSmpsTrisc
	return

isSmpsEnabled:
	; TODO: CURRENTLY ONLY REQUIRED TO PASS THE BUILD, BUT WILL BE REQUIRED AT SOME POINT !
	return

	end
