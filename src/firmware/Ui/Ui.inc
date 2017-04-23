	#ifndef __CLUCK2SESAME_UI_UI_INC
	#define __CLUCK2SESAME_UI_UI_INC
	#include "Platform.inc"

	radix decimal

UI_FLAG_PREVENTSLEEP equ 0
UI_FLAG_PUT_BANKISEL equ 1

	.module UI

	.externalVariable uiFlags
	.externalVariable uiButtonReleasedTimestamp

	#endif
