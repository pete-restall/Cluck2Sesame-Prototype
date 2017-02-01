HEX_FILES=\
	InitialisationChainTest.hex \
	SunriseAndSunsetTimesTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterSunriseSunsetMock.o

INITIALISATION_CHAIN_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	InitialisationChainTest.o

SUNRISE_AND_SUNSET_TIMES_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	SunriseAndSunsetTimesTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

SunriseAndSunsetTimesTest.hex: $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)

include $(MAKEFILE_RULES)
