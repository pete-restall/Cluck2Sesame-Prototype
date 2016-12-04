	#ifndef __CLUCK2SESAME_SMPS_SMPS_INC
	#define __CLUCK2SESAME_SMPS_SMPS_INC
	#include "p16f685.inc"

	radix decimal

	#ifndef __CLUCK2SESAME_SMPS_ENABLEDISABLE_ASM
	extern enableSmpsCount
	extern smpsFlags
	#endif

SMPS_PORT equ PORTC
SMPS_TRIS equ TRISC

SMPS_EN_PIN equ RC7
SMPS_EN_PIN_TRIS equ TRISC7
SMPS_EN_PIN_ANSH equ ANS9

SMPS_FLAG_VDD_STABLE equ 0

	#endif