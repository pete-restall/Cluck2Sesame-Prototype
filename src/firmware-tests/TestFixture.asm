	#define __CLUCK2SESAME_TESTS_TESTFIXTURE_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	#include "TestDoubles.inc"

	radix decimal

	extern testArrange


	; Non-obvious - gpsim .assert expressions are limited in size, so long
	; variable names cause weird failures.  Use the .aliasForAssert macro in
	; TestFixture.inc along with these variables to work around this.

assertAliases udata
	global _a
	global _b

_a res 1
_b res 2

TestFixtureBoot code 0x0000
	fgoto runTest

TestFixture code
runTest:
	fcall initialiseTestDoubles
	fcall testArrange
	.done

	end
