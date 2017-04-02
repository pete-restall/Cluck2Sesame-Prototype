	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_UI

Ui code
	global initialiseUi

initialiseUi:
	banksel uiState
	clrf uiState

	tcall INITIALISE_AFTER_UI

	end
