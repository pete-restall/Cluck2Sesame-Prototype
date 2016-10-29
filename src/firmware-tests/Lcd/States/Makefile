export ASARGS+=-I $(FIRMWARE_DIR)/Lcd

all:
	$(MAKE) -C EnableWaitForShiftRegister all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C EnableWaitForShiftRegister clean

include $(MAKEFILE_RULES)
