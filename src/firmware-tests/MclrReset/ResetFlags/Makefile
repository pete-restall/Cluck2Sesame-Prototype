HEX_FILES=\
	IsLastResetDueToBrownOutTest.hex

IS_LAST_RESET_DUE_TO_BROWN_OUT_OBJ_FILES=\
	IsLastResetDueToBrownOutTest.o \
	$(FIRMWARE_TESTS_DIR)/InitialiseAfterResetDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

IsLastResetDueToBrownOutTest.hex: $(OBJ_FILES) $(IS_LAST_RESET_DUE_TO_BROWN_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_LAST_RESET_DUE_TO_BROWN_OUT_OBJ_FILES)

include $(MAKEFILE_RULES)
