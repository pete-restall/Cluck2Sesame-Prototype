LIB_FILENAME=../Ui.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	Poll.o \
	BootState.o \
	SettingsBacklightNowStates.o \
	SettingsBacklightInTheDarkStates.o \
	SettingsDateTimeStates.o \
	WaitButtonPressStates.o \
	OptionStates.o \
	SettingsDateTimeStates.o \
	SettingsOpenCloseOffsetsStates.o \
	SettingsLocationStates.o \
	SettingsDoorCalibrationStates.o \
	HomeStates.o \
	DoorOverrideStates.o \
	VersionStates.pp.o \
	AdjustSettingsStates.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
