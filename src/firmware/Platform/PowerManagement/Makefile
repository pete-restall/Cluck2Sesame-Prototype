LIB_FILENAME=../PowerManagement.a
OBJ_FILES=\
	Initialise.o \
	Poll.o \
	ClockSwitching.o \
	Sleep.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
