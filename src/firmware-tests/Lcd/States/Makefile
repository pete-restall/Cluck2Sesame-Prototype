export ASARGS+=-I $(FIRMWARE_DIR)/Lcd

all:
	$(MAKE) -C EnableWaitForShiftRegister all
	$(MAKE) -C EnableWaitForMoreThan40ms all
	$(MAKE) -C Wait all
	$(MAKE) -C EnableTrySetByteMode1 all
	$(MAKE) -C EnableTrySetByteMode2 all
	$(MAKE) -C EnableSetByteMode all
	$(MAKE) -C EnableSetNibbleMode all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C EnableWaitForShiftRegister clean
	$(MAKE) -C EnableWaitForMoreThan40ms clean
	$(MAKE) -C Wait clean
	$(MAKE) -C EnableTrySetByteMode1 clean
	$(MAKE) -C EnableTrySetByteMode2 clean
	$(MAKE) -C EnableSetByteMode clean
	$(MAKE) -C EnableSetNibbleMode clean

include $(MAKEFILE_RULES)
