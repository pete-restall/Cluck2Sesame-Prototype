	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_UI

Ui code
	global initialiseUi

initialiseUi:
	tcall INITIALISE_AFTER_UI

	end
