HEX_FILES=\
	NextPollInChainTest.hex \
	NextStateWhenLcdIsNotIdleTest.hex \
	NextStateWhenLcdIsIdleTest.hex

TEST_DOUBLES=\
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/IsLcdIdleStub.o \
	$(PLATFORM_TESTS_DIR)/Lcd/AllButIsLcdIdleDummies.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterUiMock.o \
	$(TEST_DOUBLES)

NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES=\
	NextStateWhenLcdIsNotIdleTest.o \
	../../PollAfterUiDummy.o \
	$(TEST_DOUBLES)

NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES=\
	NextStateWhenLcdIsIdleTest.o \
	../../PollAfterUiDummy.o \
	$(TEST_DOUBLES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateWhenLcdIsNotIdleTest.hex: $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)

NextStateWhenLcdIsIdleTest.hex: $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
