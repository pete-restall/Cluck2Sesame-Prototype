HEX_FILES=\
	ClockSwitchingTest.hex \
	SlowTimer0OverflowTest.hex

CLOCK_SWITCHING_OBJ_FILES=\
	ClockSwitchingTest.o

SLOW_TIMER0_OVERFLOW_OBJ_FILES=\
	SlowTimer0OverflowTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ClockSwitchingTest.hex: $(OBJ_FILES) $(CLOCK_SWITCHING_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CLOCK_SWITCHING_OBJ_FILES)

SlowTimer0OverflowTest.hex: $(OBJ_FILES) $(SLOW_TIMER0_OVERFLOW_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SLOW_TIMER0_OVERFLOW_OBJ_FILES)

include $(MAKEFILE_RULES)
