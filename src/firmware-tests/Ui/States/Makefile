export ASARGS+=-I $(FIRMWARE_DIR)/Ui
export OBJ_FILES+=\
	$(CURDIR)/../InitialiseAfterUiDummy.o

TEST_FIXTURE_OBJ_FILES=\
	NextStateIsUnchangedTestFixture.o \
	NextStateIsOptionChangedTestFixture.o \
	NextStateWaitsForButtonPressTestFixture.o

all: $(TEST_FIXTURE_OBJ_FILES)
	$(MAKE) -C Boot all
	$(MAKE) -C SettingsBacklightNow all
	$(MAKE) -C Option all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Boot clean
	$(MAKE) -C SettingsBacklightNow clean
	$(MAKE) -C Option clean

include $(MAKEFILE_RULES)
