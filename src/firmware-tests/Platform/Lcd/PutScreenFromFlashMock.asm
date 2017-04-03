	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPutScreenFromFlash
	global calledPutScreenFromFlashEeadr
	global calledPutScreenFromFlashEeadrh

calledPutScreenFromFlash res 1
calledPutScreenFromFlashEeadr res 1
calledPutScreenFromFlashEeadrh res 1

PutScreenFromFlashMock code
	global initialisePutScreenFromFlashMock
	global putScreenFromFlash

initialisePutScreenFromFlashMock:
	banksel calledPutScreenFromFlash
	clrf calledPutScreenFromFlash
	clrf calledPutScreenFromFlashEeadr
	clrf calledPutScreenFromFlashEeadrh
	return

putScreenFromFlash:
	mockCalled calledPutScreenFromFlash

	banksel EEADR
	movf EEADR, W
	banksel calledPutScreenFromFlashEeadr
	movwf calledPutScreenFromFlashEeadr

	banksel EEADRH
	movf EEADRH, W
	banksel calledPutScreenFromFlashEeadrh
	movwf calledPutScreenFromFlashEeadrh
	return

	end
