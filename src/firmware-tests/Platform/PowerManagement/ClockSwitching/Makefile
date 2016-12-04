HEX_FILES=\
	ClockSwitchingTest.hex

CLOCK_SWITCHING_OBJ_FILES=\
	ClockSwitchingTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ClockSwitchingTest.hex: $(OBJ_FILES) $(CLOCK_SWITCHING_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CLOCK_SWITCHING_OBJ_FILES)

include $(MAKEFILE_RULES)
