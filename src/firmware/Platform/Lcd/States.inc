	#ifndef __CLUCK2SESAME_PLATFORM_LCD_STATES_INC
	#define __CLUCK2SESAME_PLATFORM_LCD_STATES_INC
	#include "Platform.inc"

	radix decimal

	.module LCD

LCD_STATE_DISABLED equ 0x00
LCD_STATE_IDLE equ 0x01
LCD_STATE_WAIT equ 0x02
LCD_STATE_ENABLE_WAITFORSHIFTREGISTER equ 0x03
LCD_STATE_ENABLE_WAITFORMOTORVDD equ 0x04
LCD_STATE_ENABLE_WAITFORMORETHAN40MS equ 0x05
LCD_STATE_ENABLE_WAITFORMORETHAN40MS2 equ 0x06
LCD_STATE_ENABLE_TRYSETBYTEMODE1 equ 0x07
LCD_STATE_ENABLE_TRYSETBYTEMODE2 equ 0x08
LCD_STATE_ENABLE_SETBYTEMODE equ 0x09
LCD_STATE_ENABLE_SETNIBBLEMODE equ 0x0a
LCD_STATE_ENABLE_SETDISPLAY equ 0x0b
LCD_STATE_ENABLE_DISPLAYOFF equ 0x0c
LCD_STATE_ENABLE_ENTRYMODE equ 0x0d
LCD_STATE_ENABLE_SETCONTRAST equ 0x0e
LCD_STATE_ENABLE_DISPLAYON equ 0x0f
LCD_STATE_DISPLAYCLEAR equ 0x10
LCD_STATE_WRITE_REGISTER equ 0x11
LCD_STATE_WRITE_CHARACTER equ 0x12
LCD_STATE_PUTSCREEN_READFLASH equ 0x13
LCD_STATE_PUTSCREEN_PUTCHAR equ 0x14
LCD_STATE_PUTSCREEN_NEXTLINE equ 0x15
LCD_STATE_PUTBCDDIGITS_LSD equ 0x16

LCD_STATE_LAST equ LCD_STATE_PUTBCDDIGITS_LSD

	.externalVariable lcdState
	.externalVariable lcdStateParameter0
	.externalVariable lcdStateParameter1
	.externalVariable lcdNextState

	#ifndef __CLUCK2SESAME_PLATFORM_LCD_POLL_ASM
	extern pollNextInChainAfterLcd
	#endif

setLcdState macro state
	.setBankFor lcdState
	movlw state
	movwf lcdState
	endm

setLcdNextState macro state
	.setBankFor lcdNextState
	movlw state
	movwf lcdNextState
	endm

defineLcdStateInSameSection macro name
	global lcdState#v(name)

lcdState#v(name):
	.knownBank lcdState
	endm

defineLcdState macro name
Lcd code
	defineLcdStateInSameSection name
	endm

defineLcdStateTableEntry macro i
	if (i <= LCD_STATE_LAST)
		extern lcdState#v(i)
		goto lcdState#v(i)
		defineLcdStateTableEntry i + 1
	endif
	endm

createLcdStateTable macro
	defineLcdStateTableEntry 0
	endm

returnFromLcdState macro
	goto pollNextInChainAfterLcd
	endm

	#endif
