	#ifndef __CLUCK2SESAME_SMPS_SMPS_INC
	#define __CLUCK2SESAME_SMPS_SMPS_INC
	#include "p16f685.inc"

	radix decimal

SMPS_PORT equ PORTC
SMPS_TRIS equ TRISC

SMPS_EN_PIN equ RC7
SMPS_EN_PIN_TRIS equ TRISC7
SMPS_EN_PIN_ANSH equ ANS9

	#endif