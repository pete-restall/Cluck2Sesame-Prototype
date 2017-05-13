HEX_FILES=\
	ButtonChangeWakesFromSleepTest.hex

BUTTON_CHANGE_WAKES_FROM_SLEEP_OBJ_FILES=\
	ButtonChangeWakesFromSleepTest.o \
	$(PLATFORM_DIR)/Buttons.a \
	$(PLATFORM_TESTS_DIR)/PowerManagement/InitialiseAfterPowerManagementDummy.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PollAfterPowerManagementDummy.o \
	$(PLATFORM_TESTS_DIR)/Buttons/InitialiseAfterButtonsDummy.o \
	$(PLATFORM_TESTS_DIR)/Buttons/PollAfterButtonsDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ButtonChangeWakesFromSleepTest.hex: $(OBJ_FILES) $(BUTTON_CHANGE_WAKES_FROM_SLEEP_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BUTTON_CHANGE_WAKES_FROM_SLEEP_OBJ_FILES)

include $(MAKEFILE_RULES)
