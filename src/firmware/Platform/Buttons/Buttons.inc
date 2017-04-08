	#ifndef __CLUCK2SESAME_PLATFORM_BUTTONS_BUTTONS_INC
	#define __CLUCK2SESAME_PLATFORM_BUTTONS_BUTTONS_INC
	#include "Platform.inc"

	radix decimal

	.module BUTTONS

	#define __CLUCK2SESAME_PLATFORM_BUTTONS_FLAGSONLY
	#include "../Buttons.inc"

	.externalVariable buttonLastCheckTimestamp
	.externalVariable buttonSnapshot
	.externalVariable button1State
	.externalVariable button2State

	#endif
