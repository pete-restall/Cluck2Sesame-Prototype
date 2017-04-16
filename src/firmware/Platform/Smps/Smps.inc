	#ifndef __CLUCK2SESAME_PLATFORM_SMPS_SMPS_INC
	#define __CLUCK2SESAME_PLATFORM_SMPS_SMPS_INC
	#include "Platform.inc"

	radix decimal

	.module SMPS

	.externalVariable smpsFlags
	.externalVariable enableSmpsCount
	.externalVariable enableSmpsHighPowerModeCount

SMPS_PORT equ PORTC
SMPS_TRIS equ TRISC

SMPS_EN_PIN equ RC7
SMPS_EN_PIN_TRIS equ TRISC7
SMPS_EN_PIN_ANSH equ ANS9

SMPS_FLAG_VDDSTABLE equ 0
SMPS_FLAG_HIGHPOWERMODE equ 1

	#endif
