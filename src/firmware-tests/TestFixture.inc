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

	extern _a
	extern _b

.aliasForAssert macro from, to
	banksel from
	movf from, W

	banksel to
	movwf to
	endm
