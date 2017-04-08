	#ifndef __CLUCK2SESAME_PLATFORM_FLASH_INC
	#define __CLUCK2SESAME_PLATFORM_FLASH_INC
	#include "Platform.inc"

	radix decimal

	.module FLASH

loadFlashAddressOf macro label
	.setBankFor EEADRH
	movlw high(label)
	movwf EEADRH
	movlw low(label)
	movwf EEADR
	endm

storeFlashBytesInto macro buffer
	.setBankFor buffer
	movwf (buffer + 0)

	.setBankFor EEDAT
	movf EEDAT, W
	.setBankFor buffer
	movwf (buffer + 1)
	endm

	extern readFlashWordAsPairOfSevenBitBytes
	extern readFlashWord

	#endif
