	#ifndef __CLUCK2SESAME_PLATFORM_LCD_INC
	#define __CLUCK2SESAME_PLATFORM_LCD_INC

LCD_FIRST_LINE equ b'00000000'
LCD_SECOND_LINE equ b'01000000'

	extern initialiseLcd
	extern enableLcd
	extern disableLcd
	extern isLcdEnabled
	extern isLcdIdle
	extern pollLcd
	extern putScreenFromFlash
	extern putCharacter
	extern putBcdDigit
	extern putBcdDigits
	extern setLcdCharacterPosition
	extern enableLcdBlinkingCursor
	extern disableLcdBlinkingCursor

	#endif
