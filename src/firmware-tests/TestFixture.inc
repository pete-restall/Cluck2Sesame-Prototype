.assert macro expectation
	.direct "a", expectation
	endm

.done macro
	.direct "c", "echo [PASSED]"
	.direct "c", "quit"
	endm
