HEX_FILES=\
	SetAdcChannelTest.hex \
	SetAdcChannelWhenAlreadySetTest.hex \
	SetAdcChannelAfterReleaseTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../PowerManagement/PowerManagementDummies.o

SET_ADC_CHANNEL_OBJ_FILES=\
	SetAdcChannelTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

SET_ADC_CHANNEL_WHEN_ALREADY_SET_OBJ_FILES=\
	SetAdcChannelWhenAlreadySetTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

SET_ADC_CHANNEL_AFTER_RELEASE_OBJ_FILES=\
	SetAdcChannelAfterReleaseTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SetAdcChannelTest.hex: $(OBJ_FILES) $(SET_ADC_CHANNEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_ADC_CHANNEL_OBJ_FILES)

SetAdcChannelWhenAlreadySetTest.hex: $(OBJ_FILES) $(SET_ADC_CHANNEL_WHEN_ALREADY_SET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_ADC_CHANNEL_WHEN_ALREADY_SET_OBJ_FILES)

SetAdcChannelAfterReleaseTest.hex: $(OBJ_FILES) $(SET_ADC_CHANNEL_AFTER_RELEASE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_ADC_CHANNEL_AFTER_RELEASE_OBJ_FILES)

include $(MAKEFILE_RULES)
