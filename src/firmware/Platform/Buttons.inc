	#ifndef __CLUCK2SESAME_PLATFORM_BUTTONS_INC
	#define __CLUCK2SESAME_PLATFORM_BUTTONS_INC

	radix decimal

BUTTON_FLAG_PRESSED1 equ 0
BUTTON_FLAG_PRESSED2 equ 1

	extern buttonFlags

	#ifndef __CLUCK2SESAME_PLATFORM_BUTTONS_FLAGSONLY
	extern initialiseButtons
	extern pollButtons
	#endif

	#endif