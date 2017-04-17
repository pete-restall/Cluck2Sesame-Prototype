export SUT_OBJ_FILE=$(PLATFORM_DIR)/Smps.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_DIR)/Timer0.a \
	$(PLATFORM_DIR)/PowerManagement.a \
	$(PLATFORM_TESTS_DIR)/PowerManagement/InitialiseAfterPowerManagementDummy.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PollAfterPowerManagementDummy.o \
	$(CURDIR)/InitialiseAfterSmpsMock.o \
	$(CURDIR)/PollAfterSmpsMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterSmpsMock.o \
	PollAfterSmpsMock.o \
	EnableDisableSmpsDummies.o \
	EnableDisableSmpsMocks.o \
	EnableSmpsDummies.o \
	DisableSmpsDummies.o \
	IsSmpsEnabledDummy.o \
	IsSmpsEnabledStub.o \
	PollSmpsDummy.o \
	SmpsDummies.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
