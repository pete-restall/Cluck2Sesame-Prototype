export SUT_OBJ_FILE=$(PLATFORM_DIR)/Lcd.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(PLATFORM_DIR)/Timer0.o \
	$(PLATFORM_DIR)/Flash.o \
	$(PLATFORM_DIR)/PowerManagement.a \
	$(CURDIR)/../Adc/ChannelDummies.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterLcdDummy.o \
	InitialiseAfterLcdMock.o \
	InitialiseShiftRegisterDummy.o \
	InitialiseShiftRegisterMock.o \
	EnableShiftRegisterDummy.o \
	DisableShiftRegisterDummy.o \
	EnableDisableShiftRegisterMocks.o \
	IsShiftRegisterEnabledDummy.o \
	IsShiftRegisterEnabledStub.o \
	ShiftOutDummy.o \
	ShiftOutMock.o \
	ShiftRegisterDummies.o \
	PollAfterLcdDummy.o \
	PollAfterLcdMock.o \
	AdcDummies.o \
	AdcMocks.o \
	LcdContrastDummies.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C States all
	$(MAKE) -C Contrast all
	$(MAKE) -C IsLcdIdle all
	$(MAKE) -C PutScreenFromFlash all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C States clean
	$(MAKE) -C Contrast clean
	$(MAKE) -C IsLcdIdle clean
	$(MAKE) -C PutScreenFromFlash clean

include $(MAKEFILE_RULES)
