HEX_FILES=\
	InitialiseAfterResetCalledTest.hex

INITIALISE_AFTER_RESET_CALLED_OBJ_FILES=\
	InitialiseAfterResetCalledTest.o \
	$(PLATFORM_TESTS_DIR)/InitialiseAfterResetMock.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialiseAfterResetCalledTest.hex: $(OBJ_FILES) $(INITIALISE_AFTER_RESET_CALLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISE_AFTER_RESET_CALLED_OBJ_FILES)

include $(MAKEFILE_RULES)
