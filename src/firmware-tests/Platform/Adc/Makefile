export SUT_OBJ_FILE=$(PLATFORM_DIR)/Adc.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterAdcMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterAdcDummy.o \
	InitialiseAfterAdcMock.o \
	AdcDummies.o \
	InitialiseAdcDummy.o \
	EnableDisableAdcDummies.o \
	EnableDisableAdcMocks.o \
	ChannelDummies.o \
	ChannelMocks.o \
	ChannelStubs.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C Channel all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C Channel clean

include $(MAKEFILE_RULES)
