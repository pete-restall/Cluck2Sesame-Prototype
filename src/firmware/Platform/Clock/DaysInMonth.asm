	#define __CLUCK2SESAME_PLATFORM_CLOCK_ASM

	#include "p16f685.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "TableJumps.inc"
	radix decimal

Clock code
	global lookupNumberOfDaysInMonthBcd

lookupNumberOfDaysInMonthBcd:
	tableDefinitionToJumpWith RBB
	retlw 0x00
	retlw 0x31
	retlw 0x28
	retlw 0x31
	retlw 0x30
	retlw 0x31
	retlw 0x30
	retlw 0x31
	retlw 0x31
	retlw 0x30
	retlw 0x00
	retlw 0x00
	retlw 0x00
	retlw 0x00
	retlw 0x00
	retlw 0x00
	retlw 0x31
	retlw 0x30
	retlw 0x31

	end
