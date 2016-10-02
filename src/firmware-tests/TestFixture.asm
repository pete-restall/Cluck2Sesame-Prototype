	#include "p16f685.inc"
	#include "FarCalls.inc"
	radix decimal

	extern initialiseTestDoubles
	extern testArrange


	; Non-obvious - gpsim .assert expressions are limited in size, so long
	; variable names cause weird failures.  Use the .aliasForAssert macro in
	; TestFixture.inc along with these variables to work around this.

	global _a
	global _b

assertAliases udata
_a res 1
_b res 2

boot code 0x0000
	fgoto runTest

	code
runTest:
	fcall initialiseTestDoubles
	fgoto testArrange

	end
