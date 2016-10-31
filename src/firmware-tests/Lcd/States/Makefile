export ASARGS+=-I $(FIRMWARE_DIR)/Lcd

all:
	$(MAKE) -C EnableWaitForShiftRegister all
	$(MAKE) -C EnableWaitForMoreThan40ms all
	$(MAKE) -C Wait all
	$(MAKE) -C EnableTrySetByteMode1 all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C EnableWaitForShiftRegister clean
	$(MAKE) -C EnableWaitForMoreThan40ms clean
	$(MAKE) -C Wait clean
	$(MAKE) -C EnableTrySetByteMode1 clean

include $(MAKEFILE_RULES)
