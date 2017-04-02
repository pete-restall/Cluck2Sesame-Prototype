	#ifndef __CLUCK2SESAME_UI_WAITBUTTONPRESSSTATE_INC
	#define __CLUCK2SESAME_UI_WAITBUTTONPRESSSTATE_INC

	radix decimal

	extern uiButtonEventBaseState

waitForButtonPress macro onButton1, onButton2, onBothButtons
	#if (onBothButtons != onButton2 + 1) || (onButton2 != onButton1 + 1)
		error "Button event states need to be contiguous for efficiency reasons"
	#endif

	movlw onButton1
	extern setUiStateForButtonEvents
	call setUiStateForButtonEvents
	endm

	#endif
