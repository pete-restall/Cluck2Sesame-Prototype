export PLATFORM_DIR=$(FIRMWARE_DIR)/Platform
export PLATFORM_TESTS_DIR=$(FIRMWARE_TESTS_DIR)/Platform
export PLATFORM_CORE_OBJ_FILES=\
	$(FIRMWARE_CORE_OBJ_FILES)

ASARGS+=-I $(PLATFORM_TESTS_DIR)

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterResetMock.o \
	InitialiseAfterResetDummy.o \
	InitialiseAfterTimer0Dummy.o

all: $(TEST_DOUBLE_OBJ_FILES)
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
	$(MAKE) -C Smps all
	$(MAKE) -C Motor all
	$(MAKE) -C ShiftRegister all
	$(MAKE) -C TemperatureSensor all
	$(MAKE) -C Lcd all
	$(MAKE) -C Adc all
	$(MAKE) -C Isr all
	$(MAKE) -C Flash all
	$(MAKE) -C PowerManagement all

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
	$(MAKE) -C Smps clean
	$(MAKE) -C Motor clean
	$(MAKE) -C ShiftRegister clean
	$(MAKE) -C TemperatureSensor clean
	$(MAKE) -C Lcd clean
	$(MAKE) -C Adc clean
	$(MAKE) -C Isr clean
	$(MAKE) -C Flash clean
	$(MAKE) -C PowerManagement clean

include $(MAKEFILE_RULES)
