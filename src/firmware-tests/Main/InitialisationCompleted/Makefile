HEX_FILES=\
	InterruptEnableTest.hex

INTERRUPT_ENABLE_OBJ_FILES=\
	InterruptEnableTest.o \
	$(DUMMY_ISR_OBJ_FILE) \
	../ResetDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InterruptEnableTest.hex: $(OBJ_FILES) $(INTERRUPT_ENABLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INTERRUPT_ENABLE_OBJ_FILES)

include $(MAKEFILE_RULES)
