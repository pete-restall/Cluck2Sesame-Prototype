	#ifndef __CLUCK2SESAME_UI_WAITBUTTONPRESSSTATE_INC
	#define __CLUCK2SESAME_UI_WAITBUTTONPRESSSTATE_INC
	#include "Platform.inc"

	radix decimal

	.module UI

	.externalVariable uiButtonEventBaseState

ensureStateContinguity macro onButton1, onButton2, onBothButtons
	#if (onBothButtons != onButton2 + 1) || (onButton2 != onButton1 + 1)
		error "Button event states need to be contiguous for efficiency reasons"
	#endif
	endm

waitForButtonPress macro onButton1, onButton2, onBothButtons
	ensureStateContinguity onButton1, onButton2, onBothButtons
	movlw onButton1
	extern setUiStateForButtonEvents
	call setUiStateForButtonEvents
	endm

setButtonPressEventStates macro onButton1, onButton2, onBothButtons
	ensureStateContinguity onButton1, onButton2, onBothButtons
	.setBankFor uiButtonEventBaseState
	movlw onButton1
	movwf uiButtonEventBaseState
	endm

	#endif
