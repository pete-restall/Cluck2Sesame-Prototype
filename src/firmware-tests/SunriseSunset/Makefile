export SUT_OBJ_FILE=$(FIRMWARE_DIR)/SunriseSunset.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(FIRMWARE_DIR)/Platform/Arithmetic4.o \
	$(FIRMWARE_DIR)/Platform/Arithmetic16.a \
	$(FIRMWARE_DIR)/Platform/Arithmetic32.a \
	$(FIRMWARE_DIR)/Platform/ArithmeticBcd.a \
	$(FIRMWARE_DIR)/Platform/Flash.o \
	$(CURDIR)/ClockStubs.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterSunriseSunsetMock.o \
	InitialiseAfterSunriseSunsetDummy.o \
	PollAfterSunriseSunsetMock.o \
	PollAfterSunriseSunsetDummy.o \
	ClockStubs.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C SunriseAndSunsetTimes all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C SunriseAndSunsetTimes clean

include $(MAKEFILE_RULES)
