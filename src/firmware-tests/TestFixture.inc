	#ifndef __CLUCK2SESAME_TESTS_TESTFIXTURE_INC
	#define __CLUCK2SESAME_TESTS_TESTFIXTURE_INC

.assert macro expectation
	nop
	.direct "a", expectation
	nop
	endm

.done macro
	nop
	.direct "c", "echo [PASSED]"
	.direct "c", "quit"
	nop
	endm


	; Non-obvious - gpsim .assert expressions are limited in size, so long
	; variable names cause weird failures.  These variables and macro allow
	; shorter variable names to be used in assertions.

	#ifndef __CLUCK2SESAME_TESTS_TESTFIXTURE_ASM
	extern _a
	extern _b
	#endif

.aliasForAssert macro from, to
	banksel from
	movf from, W

	.aliasWForAssert to
	endm

.aliasWForAssert macro to
	banksel to
	movwf to
	endm

	#endif
