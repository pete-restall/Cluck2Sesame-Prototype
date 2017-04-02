	#ifndef __CLUCK2SESAME_PLATFORM_LCD_LCD_INC
	#define __CLUCK2SESAME_PLATFORM_LCD_LCD_INC
	#include "Isr.inc"

	radix decimal

V_0_5 equ 5
V_3_3 equ 33
DEFAULT_LCD_CONTRAST equ 256 * V_0_5 / V_3_3

LCD_BACKLIGHT_EN_BIT equ 6
LCD_DB7_BIT equ 5
LCD_DB6_BIT equ 4
LCD_DB5_BIT equ 3
LCD_DB4_BIT equ 2
LCD_EN_BIT equ 1
LCD_RS_BIT equ 0
NON_LCD_BITS_MASK equ b'10000000'
NON_LCD_DATA_BITS_MASK equ NON_LCD_BITS_MASK | (1 << LCD_BACKLIGHT_EN_BIT)

LCD_CMD_SETDISPLAY equ b'00100000'
LCD_CMD_SETDISPLAY_TWOLINES equ b'00001000'
LCD_CMD_SETDISPLAY_5X8 equ b'00000000'

LCD_CMD_DISPLAYOFF equ b'00001000'

LCD_CMD_DISPLAYCLEAR equ b'00000001'

LCD_CMD_ENTRYMODE equ b'00000100'
LCD_CMD_ENTRYMODE_INCREMENTING equ b'00000010'
LCD_CMD_ENTRYMODE_NOSHIFT equ b'00000000'

LCD_CMD_DISPLAYON equ b'00001100'

LCD_CMD_SETDDRAMADDRESS equ b'10000000'
LCD_CMD_SETDDRAMADDRESS_LINE2 equ LCD_CMD_SETDDRAMADDRESS | 0x40

	extern lcdContrast
	extern enableLcdCount
	extern lcdFlags
	extern lcdWorkingRegister
	extern flashPointerMsb
	extern flashPointerLsb
	extern numberOfCharactersRemaining
	extern characters

	#ifndef __CLUCK2SESAME_PLATFORM_LCD_WRITE_ASM
	extern writeRegister
	extern writeCharacter
	extern writeRegisterNibble
	extern writeRegisterFromWWithIdleNextState
	#endif

	#endif
