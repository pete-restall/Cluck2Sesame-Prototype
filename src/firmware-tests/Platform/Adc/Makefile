export SUT_OBJ_FILE=$(PLATFORM_DIR)/Adc.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterAdcMock.o

all: InitialiseAfterAdcDummy.o InitialiseAfterAdcMock.o
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean

include $(MAKEFILE_RULES)
