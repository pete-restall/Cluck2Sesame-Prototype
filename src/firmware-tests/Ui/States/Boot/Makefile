HEX_FILES=\
	NextPollInChainTest.hex \
	NextStateTest.hex \
	EnsureFastClockTest.hex \
	EnableLcdTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterUiMock.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

NEXT_STATE_OBJ_FILES=\
	NextStateTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENSURE_FAST_CLOCK_OBJ_FILES=\
	EnsureFastClockTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementMocks.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_LCD_OBJ_FILES=\
	EnableLcdTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementMocks.o \
	$(PLATFORM_TESTS_DIR)/Lcd/EnableDisableLcdMocks.o \
	$(PLATFORM_TESTS_DIR)/Lcd/AllButEnableDisableLcdDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateTest.hex: $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)

EnsureFastClockTest.hex: $(OBJ_FILES) $(ENSURE_FAST_CLOCK_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENSURE_FAST_CLOCK_OBJ_FILES)

EnableLcdTest.hex: $(OBJ_FILES) $(ENABLE_LCD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_LCD_OBJ_FILES)

include $(MAKEFILE_RULES)
