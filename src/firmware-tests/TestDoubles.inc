	extern spyCallCounter

spyCalled macro counter
	banksel spyCallCounter
	incf spyCallCounter
	movf spyCallCounter, W

	banksel counter
	movwf counter
	endm
