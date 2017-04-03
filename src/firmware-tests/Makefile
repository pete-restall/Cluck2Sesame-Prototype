export FIRMWARE_TESTS_DIR=$(BASE_DIR)/firmware-tests
export PLATFORM_TESTS_DIR=$(FIRMWARE_TESTS_DIR)/Platform
export FIRMWARE_CORE_OBJ_FILES=\
	$(FIRMWARE_DIR)/ConfigWords.o \
	$(FIRMWARE_DIR)/Platform/ResetFlags.o \
	$(FIRMWARE_DIR)/Platform/GeneralPurposeRegisters.o

export TEST_FIXTURE_OBJ_FILES=\
	$(FIRMWARE_TESTS_DIR)/TestFixture.o \
	$(FIRMWARE_TESTS_DIR)/TestDoubles.o

export ASSERT_NO_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/AssertNoIsr.o
export DUMMY_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/IsrDummy.o

export PLATFORM_DIR=$(FIRMWARE_DIR)/Platform

ASARGS+=-I $(FIRMWARE_TESTS_DIR)

TEST_DOUBLE_OBJ_FILES=\
	TestFixture.o \
	TestDoubles.o \
	AssertNoIsr.o \
	IsrDummy.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(UTILITIES_DIR)/randomise-ram/randomise-ram RandomiseRam.sti
	$(MAKE) -C Platform all
	$(MAKE) -C Ui all
	$(MAKE) -C SunriseSunset all
	$(MAKE) -C Door all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Platform clean
	$(MAKE) -C Ui clean
	$(MAKE) -C SunriseSunset clean
	$(MAKE) -C Door clean

include $(MAKEFILE_RULES)
