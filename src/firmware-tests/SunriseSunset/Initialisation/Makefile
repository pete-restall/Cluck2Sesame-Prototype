HEX_FILES=\
	InitialisationChainTest.hex \
	SunriseAndSunsetTimesTest.hex \
	LatitudeAndLongitudeOffsetsTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterSunriseSunsetMock.o

INITIALISATION_CHAIN_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	InitialisationChainTest.o

SUNRISE_AND_SUNSET_TIMES_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	SunriseAndSunsetTimesTest.o

LATITUDE_AND_LONGITUDE_OFFSETS_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	LatitudeAndLongitudeOffsetsTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

SunriseAndSunsetTimesTest.hex: $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)

LatitudeAndLongitudeOffsetsTest.hex: $(OBJ_FILES) $(LATITUDE_AND_LONGITUDE_OFFSETS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(LATITUDE_AND_LONGITUDE_OFFSETS_OBJ_FILES)

include $(MAKEFILE_RULES)
