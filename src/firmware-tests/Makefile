export FIRMWARE_TESTS_DIR=$(BASE_DIR)/firmware-tests
export FIRMWARE_CORE_OBJ_FILES=\
	$(FIRMWARE_DIR)/ConfigWords.o

export TEST_FIXTURE_OBJ_FILES=\
	$(FIRMWARE_TESTS_DIR)/TestFixture.o \
	$(FIRMWARE_TESTS_DIR)/TestDoubles.o

export ASSERT_NO_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/AssertNoIsr.o

ASARGS+=-I $(FIRMWARE_TESTS_DIR)

all: TestFixture.o TestDoubles.o AssertNoIsr.o InitialiseAfterResetMock.o InitialiseAfterResetDummy.o
	$(MAKE) -C Main all
	$(MAKE) -C PowerOnReset all
	$(MAKE) -C BrownOutReset all
	$(MAKE) -C MclrReset all
	$(MAKE) -C InitialisationChain all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Main clean
	$(MAKE) -C PowerOnReset clean
	$(MAKE) -C BrownOutReset clean
	$(MAKE) -C MclrReset clean
	$(MAKE) -C InitialisationChain clean

include $(MAKEFILE_RULES)
