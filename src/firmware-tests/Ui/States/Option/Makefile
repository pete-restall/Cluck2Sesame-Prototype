HEX_FILES=\
	NextPollInChainTest.hex \
	NextStateWaitsForButtonPressTest.hex

TEST_DOUBLES=\
	LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/IsLcdIdleStub.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterUiMock.o \
	$(TEST_DOUBLES)

NEXT_STATE_WAITS_FOR_BUTTON_PRESS_OBJ_FILES=\
	NextStateWaitsForButtonPressTest.o \
	../NextStateWaitsForButtonPressTestFixture.o \
	../../PollAfterUiDummy.o \
	$(TEST_DOUBLES)

all: LcdDummies.o $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateWaitsForButtonPressTest.hex: $(OBJ_FILES) $(NEXT_STATE_WAITS_FOR_BUTTON_PRESS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_WAITS_FOR_BUTTON_PRESS_OBJ_FILES)

include $(MAKEFILE_RULES)
