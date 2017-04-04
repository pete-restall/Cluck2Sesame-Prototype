HEX_FILES=\
	NextPollInChainTest.hex \
	ButtonPressTest.hex

TEST_DOUBLES=\
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterUiMock.o \
	$(TEST_DOUBLES)

BUTTON_PRESS_OBJ_FILES=\
	ButtonPressTest.o \
	../../PollAfterUiDummy.o \
	$(TEST_DOUBLES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

ButtonPressTest.hex: $(OBJ_FILES) $(BUTTON_PRESS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BUTTON_PRESS_OBJ_FILES)

include $(MAKEFILE_RULES)
