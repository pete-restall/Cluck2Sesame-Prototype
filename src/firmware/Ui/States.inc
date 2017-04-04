	#ifndef __CLUCK2SESAME_UI_STATES_INC
	#define __CLUCK2SESAME_UI_STATES_INC

	radix decimal

UI_STATE_BOOT equ 0x00
UI_STATE_SETTINGS_BACKLIGHTNOW equ 0x01
UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT equ 0x02
UI_STATE_SETTINGS_BACKLIGHTNOW_RIGHT equ 0x03
UI_STATE_SETTINGS_BACKLIGHTNOW_ENTER equ 0x04
UI_STATE_WAIT_BUTTONPRESS equ 0x05
UI_STATE_OPTION_CHANGED equ 0x06
UI_STATE_OPTION_CHANGED2 equ 0x07
UI_STATE_OPTION_CHANGED3 equ 0x08

UI_STATE_LAST equ UI_STATE_OPTION_CHANGED3

UI_STATE_SETTINGS equ UI_STATE_SETTINGS_BACKLIGHTNOW

	extern uiState
	extern uiNextState

	#ifndef __CLUCK2SESAME_UI_POLL_ASM
	extern pollNextInChainAfterUi
	#endif

setUiState macro state
	banksel uiState
	movlw state
	movwf uiState
	endm

setUiNextState macro state
	banksel uiNextState
	movlw state
	movwf uiNextState
	endm

defineUiStateInSameSection macro name
	global uiState#v(name)

uiState#v(name):
	endm

defineUiState macro name
Ui code
	defineUiStateInSameSection name
	endm

defineUiStateTableEntry macro i
	if (i <= UI_STATE_LAST)
		extern uiState#v(i)
		goto uiState#v(i)
		defineUiStateTableEntry i + 1
	endif
	endm

createUiStateTable macro
	defineUiStateTableEntry 0
	endm

returnFromUiState macro
	goto pollNextInChainAfterUi
	endm

	#endif
