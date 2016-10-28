export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Lcd.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterLcdMock.o

all: InitialiseAfterLcdMock.o InitialiseShiftRegisterMock.o EnableDisableShiftRegisterMocks.o ShiftOutMock.o ShiftRegisterDummies.o
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean

include $(MAKEFILE_RULES)
