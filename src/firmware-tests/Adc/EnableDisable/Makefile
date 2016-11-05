HEX_FILES=\
	EnableDisableAdcTest.hex \
	EnableAdcCalledTwiceTest.hex

ENABLE_DISABLE_ADC_OBJ_FILES=\
	EnableDisableAdcTest.o

ENABLE_ADC_CALLED_TWICE_OBJ_FILES=\
	EnableAdcCalledTwiceTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableAdcTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_ADC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_ADC_OBJ_FILES)

EnableAdcCalledTwiceTest.hex: $(OBJ_FILES) $(ENABLE_ADC_CALLED_TWICE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_ADC_CALLED_TWICE_OBJ_FILES)

include $(MAKEFILE_RULES)
