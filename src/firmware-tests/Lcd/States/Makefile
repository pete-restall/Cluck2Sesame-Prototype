export ASARGS+=-I $(FIRMWARE_DIR)/Lcd
export OBJ_FILES+=\
	$(CURDIR)/../InitialiseAfterLcdDummy.o \
	$(ASSERT_NO_ISR_OBJ_FILE)

all:
	$(MAKE) -C EnableWaitForShiftRegister all
	$(MAKE) -C EnableWaitForMoreThan40ms all
	$(MAKE) -C Wait all
	$(MAKE) -C EnableTrySetByteMode1 all
	$(MAKE) -C EnableTrySetByteMode2 all
	$(MAKE) -C EnableSetByteMode all
	$(MAKE) -C EnableSetNibbleMode all
	$(MAKE) -C EnableSetDisplay all
	$(MAKE) -C EnableDisplayOff all
	$(MAKE) -C DisplayClear all
	$(MAKE) -C EnableEntryMode all
	$(MAKE) -C EnableSetContrast all
	$(MAKE) -C EnableDisplayOn all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C EnableWaitForShiftRegister clean
	$(MAKE) -C EnableWaitForMoreThan40ms clean
	$(MAKE) -C Wait clean
	$(MAKE) -C EnableTrySetByteMode1 clean
	$(MAKE) -C EnableTrySetByteMode2 clean
	$(MAKE) -C EnableSetByteMode clean
	$(MAKE) -C EnableSetNibbleMode clean
	$(MAKE) -C EnableSetDisplay clean
	$(MAKE) -C EnableDisplayOff clean
	$(MAKE) -C DisplayClear clean
	$(MAKE) -C EnableEntryMode clean
	$(MAKE) -C EnableSetContrast clean
	$(MAKE) -C EnableDisplayOn clean

include $(MAKEFILE_RULES)
