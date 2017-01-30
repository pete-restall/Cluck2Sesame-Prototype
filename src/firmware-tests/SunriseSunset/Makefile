export SUT_OBJ_FILE=$(FIRMWARE_DIR)/SunriseSunset.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterSunriseSunsetMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterSunriseSunsetMock.o \
	PollAfterSunriseSunsetMock.o

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
