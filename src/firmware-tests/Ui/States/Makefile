export ASARGS+=-I $(FIRMWARE_DIR)/Ui
export OBJ_FILES+=\
	$(CURDIR)/../InitialiseAfterUiDummy.o

all:
	$(MAKE) -C Boot all
	$(MAKE) -C SettingsBacklightNow all
	$(MAKE) -C WaitButtonPress all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Boot clean
	$(MAKE) -C SettingsBacklightNow clean
	$(MAKE) -C WaitButtonPress clean

include $(MAKEFILE_RULES)
