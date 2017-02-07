LIB_FILENAME=../SunriseSunset.a
OBJ_FILES=\
	Registers.o \
	RegisterLoadAndStore.o \
	Coefficients.o \
	Initialise.o \
	CalculateSunriseAndSunset.o \
	Poll.o \
	UninitialisedState.o \
	IdleState.o \
	CalculateSunriseState.o \
	SunriseLimitDayOfYearState.o \
	DayOfYearState.o \
	CurveFitStates.o \
	SunriseLatitudeAdjustmentState.o \
	SunsetStoreStates.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
