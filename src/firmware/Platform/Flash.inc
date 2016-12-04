	#ifndef __CLUCK2SESAME_PLATFORM_FLASH_INC
	#define __CLUCK2SESAME_PLATFORM_FLASH_INC

loadFlashAddressOf macro label
	banksel EEADRH
	movlw high(label)
	movwf EEADRH
	movlw low(label)
	movwf EEADR
	endm

storeFlashWordInto macro buffer
	banksel buffer
	movwf (buffer + 0)

	banksel EEDAT
	movf EEDAT, W
	banksel buffer
	movwf (buffer + 1)
	endm

	extern readFlashWordAsPairOfSevenBitBytes

	#endif
