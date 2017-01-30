HEX_FILES=\
	PreventSleepTest.hex

PREVENT_SLEEP_OBJ_FILES=\
	PreventSleepTest.o \
	../InitialiseAfterIsrDummy.o \
	../ClockDummies.o \

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PreventSleepTest.hex: $(OBJ_FILES) $(PREVENT_SLEEP_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PREVENT_SLEEP_OBJ_FILES)

include $(MAKEFILE_RULES)
