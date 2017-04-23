	#ifndef __CLUCK2SESAME_UI_PUTBCDSTRINGSTATE_INC
	#define __CLUCK2SESAME_UI_PUTBCDSTRINGSTATE_INC
	#include "Platform.inc"

	radix decimal

	.module UI

	.externalVariable uiBcdCount
	.externalVariable uiBcdIncrement
	.externalVariable uiBcdPointer
	.externalVariable uiBcdPosition
	.externalVariable uiBcdNextState

setupPutBcdString macro ptr, count, startPos, increment
		.setBankFor uiBcdPosition
		movlw startPos
		movwf uiBcdPosition

		#if high(ptr) != 0x00
		bsf uiFlags, UI_FLAG_PUT_BANKISEL
		#else
		bcf uiFlags, UI_FLAG_PUT_BANKISEL
		#endif
		movlw low(ptr)
		movwf uiBcdPointer

		movlw increment
		movwf uiBcdIncrement

		movlw count
		movwf uiBcdCount
		endm

	#endif
