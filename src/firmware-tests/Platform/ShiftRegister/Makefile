export SUT_OBJ_FILE=$(PLATFORM_DIR)/ShiftRegister.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterShiftRegisterMock.o \
	$(CURDIR)/PollMotorMock.o

TEST_DOUBLES=\
	InitialiseAfterShiftRegisterMock.o \
	EnableDisableMotorVddStubs.o \
	PollMotorMock.o

all: $(TEST_DOUBLES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C ShiftOut all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C ShiftOut clean

include $(MAKEFILE_RULES)
