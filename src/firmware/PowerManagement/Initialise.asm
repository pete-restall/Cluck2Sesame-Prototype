	#define __CLUCK2SESAME_POWERMANAGEMENT_INITIALISE_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_POWERMANAGEMENT

	udata
	global powerManagementFlags

powerManagementFlags res 1

PowerManagement code
	global initialisePowerManagement

initialisePowerManagement:
	banksel powerManagementFlags
	clrf powerManagementFlags

	tcall INITIALISE_AFTER_POWERMANAGEMENT

	end
