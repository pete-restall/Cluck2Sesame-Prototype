LIB_FILENAME=../Clock.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	Poll.o \
	DaysInMonth.o \
	DaylightSavingsTime.o \
	DaylightSavingsTimeLookupTable.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
