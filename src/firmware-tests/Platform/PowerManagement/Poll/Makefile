HEX_FILES=\
	SleepWhenNotPreventedTest.hex \
	SleepWhenNotPreventedAgainTest.hex \
	NoSleepWhenPreventedTest.hex \
	NoSleepWhenAdcTest.hex \
	NoSleepWhenTimer2Test.hex

SLEEP_WHEN_NOT_PREVENTED_OBJ_FILES=\
	SleepWhenNotPreventedTest.o

SLEEP_WHEN_NOT_PREVENTED_AGAIN_OBJ_FILES=\
	SleepWhenNotPreventedAgainTest.o

NO_SLEEP_WHEN_PREVENTED_OBJ_FILES=\
	NoSleepWhenPreventedTest.o

NO_SLEEP_WHEN_ADC_OBJ_FILES=\
	NoSleepWhenAdcTest.o

NO_SLEEP_WHEN_TIMER2_OBJ_FILES=\
	NoSleepWhenTimer2Test.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SleepWhenNotPreventedTest.hex: $(OBJ_FILES) $(SLEEP_WHEN_NOT_PREVENTED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SLEEP_WHEN_NOT_PREVENTED_OBJ_FILES)

SleepWhenNotPreventedAgainTest.hex: $(OBJ_FILES) $(SLEEP_WHEN_NOT_PREVENTED_AGAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SLEEP_WHEN_NOT_PREVENTED_AGAIN_OBJ_FILES)

NoSleepWhenPreventedTest.hex: $(OBJ_FILES) $(NO_SLEEP_WHEN_PREVENTED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NO_SLEEP_WHEN_PREVENTED_OBJ_FILES)

NoSleepWhenAdcTest.hex: $(OBJ_FILES) $(NO_SLEEP_WHEN_ADC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NO_SLEEP_WHEN_ADC_OBJ_FILES)

NoSleepWhenTimer2Test.hex: $(OBJ_FILES) $(NO_SLEEP_WHEN_TIMER2_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NO_SLEEP_WHEN_TIMER2_OBJ_FILES)

include $(MAKEFILE_RULES)
