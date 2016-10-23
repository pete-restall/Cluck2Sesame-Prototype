HEX_FILES=\
	EnableDisableSmpsTest.hex \
	IsEnabledAfterInitialisationTest.hex

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	EnableDisableSmpsTest.o

IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES=\
	IsEnabledAfterInitialisationTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableSmpsTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)

IsEnabledAfterInitialisationTest.hex: $(OBJ_FILES) $(IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES)

include $(MAKEFILE_RULES)
