	#define __CLUCK2SESAME_UI_POLL_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_UI

Ui code
	global pollUi
	global pollNextInChainAfterUi

pollUi:
	tableDefinitionToJumpWith uiState
	createUiStateTable

pollNextInChainAfterUi:
	tcall POLL_AFTER_UI

	end
