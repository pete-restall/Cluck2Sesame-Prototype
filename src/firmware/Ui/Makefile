LIB_FILENAME=../Ui.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	Poll.o \
	Screens.pp.o \
	BootState.o \
	SettingsBacklightNowStates.o \
	WaitButtonPressStates.o \
	OptionStates.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
