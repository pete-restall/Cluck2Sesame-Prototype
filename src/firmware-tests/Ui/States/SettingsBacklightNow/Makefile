HEX_FILES=\
	NextPollInChainTest.hex \
	NextStateWhenLcdIsNotIdleTest.hex \
	NextStateWhenLcdIsIdleTest.hex \
	PutScreenWhenLcdIsNotIdleTest.hex \
	PutScreenWhenLcdIsIdleTest.hex \
	BacklightWhenLcdIsNotIdleTest.hex \
	BacklightWhenLcdIsIdleTest.hex

TEST_DOUBLES=\
	LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/IsLcdIdleStub.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterUiMock.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightDummies.o \
	$(TEST_DOUBLES)

NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES=\
	NextStateWhenLcdIsNotIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightDummies.o \
	$(TEST_DOUBLES)

NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES=\
	NextStateWhenLcdIsIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightDummies.o \
	$(TEST_DOUBLES)

PUT_SCREEN_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES=\
	PutScreenWhenLcdIsNotIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashMock.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightDummies.o \
	$(TEST_DOUBLES)

PUT_SCREEN_WHEN_LCD_IS_IDLE_OBJ_FILES=\
	PutScreenWhenLcdIsIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashMock.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightDummies.o \
	$(TEST_DOUBLES)

BACKLIGHT_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES=\
	BacklightWhenLcdIsNotIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightMocks.o \
	$(TEST_DOUBLES)

BACKLIGHT_WHEN_LCD_IS_IDLE_OBJ_FILES=\
	BacklightWhenLcdIsIdleTest.o \
	../../PollAfterUiDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/PutScreenFromFlashDummy.o \
	$(PLATFORM_TESTS_DIR)/Lcd/BacklightMocks.o \
	$(TEST_DOUBLES)

all: LcdDummies.o $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateWhenLcdIsNotIdleTest.hex: $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)

NextStateWhenLcdIsIdleTest.hex: $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_WHEN_LCD_IS_IDLE_OBJ_FILES)

PutScreenWhenLcdIsNotIdleTest.hex: $(OBJ_FILES) $(PUT_SCREEN_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_SCREEN_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)

PutScreenWhenLcdIsIdleTest.hex: $(OBJ_FILES) $(PUT_SCREEN_WHEN_LCD_IS_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_SCREEN_WHEN_LCD_IS_IDLE_OBJ_FILES)

BacklightWhenLcdIsNotIdleTest.hex: $(OBJ_FILES) $(BACKLIGHT_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BACKLIGHT_WHEN_LCD_IS_NOT_IDLE_OBJ_FILES)

BacklightWhenLcdIsIdleTest.hex: $(OBJ_FILES) $(BACKLIGHT_WHEN_LCD_IS_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BACKLIGHT_WHEN_LCD_IS_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
