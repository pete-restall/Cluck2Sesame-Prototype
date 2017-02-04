HEX_FILES=\
	SunriseAndSunsetTimesTest.hex

SUNRISE_AND_SUNSET_TIMES_OBJ_FILES=\
	SunriseAndSunsetTimesTest.o \
	../InitialiseAfterSunriseSunsetDummy.o \
	../PollAfterSunriseSunsetDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SunriseAndSunsetTimesTest.hex: $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SUNRISE_AND_SUNSET_TIMES_OBJ_FILES)

include $(MAKEFILE_RULES)
