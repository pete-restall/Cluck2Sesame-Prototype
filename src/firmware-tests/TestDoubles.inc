	extern mockCallCounter

mockCalled macro counter
	banksel mockCallCounter
	incf mockCallCounter
	movf mockCallCounter, W

	banksel counter
	movwf counter
	endm
