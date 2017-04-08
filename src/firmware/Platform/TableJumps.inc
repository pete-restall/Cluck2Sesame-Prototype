	#ifndef __CLUCK2SESAME_PLATFORM_TABLE_JUMPS_INC
	#define __CLUCK2SESAME_PLATFORM_TABLE_JUMPS_INC

	radix decimal

tableDefinitionToJumpWith macro indexRegister
	local tableStart

	.setBankFor indexRegister
	movlw high tableStart
	movwf PCLATH
	movf indexRegister, W
	addlw tableStart
	btfsc STATUS, C
	incf PCLATH
	movwf PCL

tableStart:
	endm

	#endif
