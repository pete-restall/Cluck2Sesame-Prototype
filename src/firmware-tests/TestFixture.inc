	#ifndef __CLUCK2SESAME_TESTS_TESTFIXTURE_INC
	#define __CLUCK2SESAME_TESTS_TESTFIXTURE_INC

.assert macro expectation
	nop
	.direct "a", expectation
	nop
	endm

.command macro gpsimCommand
	nop
	.direct "c", gpsimCommand
	nop
	endm

.signalTestCompletion macro
	extern testCompleted
	banksel testCompleted
	comf testCompleted
	endm

.done macro
	.command "echo [PASSED]"
	.signalTestCompletion
	endm

.assertTraceExternally macro
	.command "echo [PENDING]"
	.signalTestCompletion
	endm


	; Non-obvious - gpsim .assert expressions use the same bank as currently
	; selected.  Use the .aliasForAssert macro along with these variables to
	; work around expressions asserting over several banks.

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

.aliasLiteralForAssert macro literal, to
	movlw literal
	.aliasWForAssert to
	endm

	#endif
