	#ifndef __CLUCK2SESAME_PLATFORM_SMPS_SMPS_INC
	#define __CLUCK2SESAME_PLATFORM_SMPS_SMPS_INC
	#include "Platform.inc"

	radix decimal

	.module SMPS

	#ifndef __CLUCK2SESAME_PLATFORM_SMPS_ENABLEDISABLE_ASM
	.externalVariable enableSmpsCount
	.externalVariable smpsFlags
	#endif

SMPS_PORT equ PORTC
SMPS_TRIS equ TRISC

SMPS_EN_PIN equ RC7
SMPS_EN_PIN_TRIS equ TRISC7
SMPS_EN_PIN_ANSH equ ANS9

SMPS_FLAG_VDD_STABLE equ 0

	#endif
