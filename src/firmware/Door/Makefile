LIB_FILENAME=../Door.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	DoorSettingsAreComplete.o \
	Poll.o \
	NewDayStates.o \
	SunriseSunsetStates.o \
	OpenStates.o \
	CloseStates.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
