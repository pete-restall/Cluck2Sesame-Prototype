OBJ_FILES+=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../PollAfterClockDummy.o \
	../../ResetFlagsStubs.o

HEX_FILES=\
	DaylightSavingsTimeTest.hex

DAYLIGHT_SAVINGS_TIME_OBJ_FILES=\
	DaylightSavingsTimeTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

DaylightSavingsTimeTest.hex: $(OBJ_FILES) $(DAYLIGHT_SAVINGS_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DAYLIGHT_SAVINGS_TIME_OBJ_FILES)

include $(MAKEFILE_RULES)
