.assert macro expectation
	.direct "a", expectation
	endm

.done macro
	.direct "c", "quit"
	endm
