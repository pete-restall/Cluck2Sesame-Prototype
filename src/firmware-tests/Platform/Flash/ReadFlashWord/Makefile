HEX_FILES=\
	ReadFlashWordTest.hex

READ_FLASH_WORD_OBJ_FILES=\
	ReadFlashWordTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ReadFlashWordTest.hex: $(OBJ_FILES) $(READ_FLASH_WORD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(READ_FLASH_WORD_OBJ_FILES)

include $(MAKEFILE_RULES)
