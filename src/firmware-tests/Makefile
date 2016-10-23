export FIRMWARE_TESTS_DIR=$(BASE_DIR)/firmware-tests
export FIRMWARE_CORE_OBJ_FILES=\
	$(FIRMWARE_DIR)/ConfigWords.o \
	$(FIRMWARE_DIR)/GeneralPurposeRegisters.o

export TEST_FIXTURE_OBJ_FILES=\
	$(FIRMWARE_TESTS_DIR)/TestFixture.o \
	$(FIRMWARE_TESTS_DIR)/TestDoubles.o

export ASSERT_NO_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/AssertNoIsr.o
export DUMMY_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/IsrDummy.o

ASARGS+=-I $(FIRMWARE_TESTS_DIR)

all: TestFixture.o TestDoubles.o AssertNoIsr.o IsrDummy.o InitialiseAfterResetMock.o InitialiseAfterResetDummy.o
	$(MAKE) -C Main all
	$(MAKE) -C PowerOnReset all
	$(MAKE) -C BrownOutReset all
	$(MAKE) -C MclrReset all
	$(MAKE) -C InitialisationChain all
	$(MAKE) -C Timer0 all
	$(MAKE) -C Clock all
	$(MAKE) -C Arithmetic4 all
	$(MAKE) -C Arithmetic32 all
	$(MAKE) -C ArithmeticBcd all
	$(MAKE) -C ShiftRegister all
	$(MAKE) -C Smps all
	$(MAKE) -C Motor all
	$(MAKE) -C TemperatureSensor all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Main clean
	$(MAKE) -C PowerOnReset clean
	$(MAKE) -C BrownOutReset clean
	$(MAKE) -C MclrReset clean
	$(MAKE) -C InitialisationChain clean
	$(MAKE) -C Timer0 clean
	$(MAKE) -C Clock clean
	$(MAKE) -C Arithmetic4 clean
	$(MAKE) -C Arithmetic32 clean
	$(MAKE) -C ArithmeticBcd clean
	$(MAKE) -C ShiftRegister clean
	$(MAKE) -C Smps clean
	$(MAKE) -C Motor clean
	$(MAKE) -C TemperatureSensor clean

include $(MAKEFILE_RULES)
