export SUT_OBJ_FILE=$(PLATFORM_DIR)/Lcd.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(PLATFORM_DIR)/Timer0.a \
	$(PLATFORM_TESTS_DIR)/Timer0/PollAfterTimer0Dummy.o \
	$(PLATFORM_DIR)/Flash.o \
	$(PLATFORM_DIR)/PowerManagement.a \
	$(CURDIR)/../Adc/ChannelDummies.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterLcdDummy.o \
	InitialiseAfterLcdMock.o \
	EnableDisableLcdMocks.o \
	PollAfterLcdDummy.o \
	PollAfterLcdMock.o \
	AdcDummies.o \
	AdcMocks.o \
	LcdContrastDummies.o \
	LcdDummies.o \
	IsLcdIdleStub.o \
	PutScreenFromFlashDummy.o \
	PutScreenFromFlashMock.o \
	BacklightDummies.o \
	BacklightMocks.o

TEST_FIXTURES=\
	WriteRegisterTestFixture.o

all: $(TEST_DOUBLE_OBJ_FILES) $(TEST_FIXTURES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C States all
	$(MAKE) -C Contrast all
	$(MAKE) -C IsLcdIdle all
	$(MAKE) -C PutScreenFromFlash all
	$(MAKE) -C PutCharacters all
	$(MAKE) -C SetCursorPosition all
	$(MAKE) -C BlinkingCursor all
	$(MAKE) -C Backlight all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C States clean
	$(MAKE) -C Contrast clean
	$(MAKE) -C IsLcdIdle clean
	$(MAKE) -C PutScreenFromFlash clean
	$(MAKE) -C PutCharacters clean
	$(MAKE) -C SetCursorPosition clean
	$(MAKE) -C BlinkingCursor clean
	$(MAKE) -C Backlight clean

include $(MAKEFILE_RULES)
