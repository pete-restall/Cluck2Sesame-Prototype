LIB_FILENAME=../SunriseSunset.a
OBJ_FILES=\
	Registers.o \
	RegisterLoadAndStore.o \
	LookupTables.o \
	Initialise.o \
	CalculateSunriseAndSunset.o \
	Poll.o \
	SignedMultiply.o \
	LoadLookupTableEntryFromFlash.o \
	UninitialisedState.o \
	IdleState.o \
	CalculateSunriseState.o \
	SunriseLoadLookupsStates.o \
	LoadLookupsStates.o \
	InterpolationStates.o \
	AccumulatorToTimeStates.o \
	SunriseStoreStates.o \
	CalculateSunsetState.o \
	SunsetLoadLookupsStates.o \
	SunsetStoreStates.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
