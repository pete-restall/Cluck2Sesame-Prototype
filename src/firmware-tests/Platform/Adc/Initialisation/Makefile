HEX_FILES=\
	InitialisationChainTest.hex \
	Pie1Test.hex \
	Pir1Test.hex \
	AdcDisabledTest.hex \
	ChannelIs0VComparatorReferenceTest.hex \
	LeftJustifiedTest.hex \
	VddAsVoltageReferenceTest.hex \
	SampleRateIs11kHzTest.hex

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../../PowerManagement/PowerManagementDummies.o

PIE1_OBJ_FILES=\
	Pie1Test.o \
	../../PowerManagement/PowerManagementDummies.o

PIR1_OBJ_FILES=\
	Pir1Test.o \
	../../PowerManagement/PowerManagementDummies.o

ADC_DISABLED_OBJ_FILES=\
	AdcDisabledTest.o \
	../../PowerManagement/PowerManagementDummies.o

CHANNEL_IS_0V_COMPARATOR_REFERENCE_OBJ_FILES=\
	ChannelIs0VComparatorReferenceTest.o \
	../../PowerManagement/PowerManagementDummies.o

LEFT_JUSTIFIED_OBJ_FILES=\
	LeftJustifiedTest.o \
	../../PowerManagement/PowerManagementDummies.o

VDD_AS_VOLTAGE_REFERENCE_OBJ_FILES=\
	VddAsVoltageReferenceTest.o \
	../../PowerManagement/PowerManagementDummies.o

SAMPLE_RATE_IS_11KHZ_OBJ_FILES=\
	SampleRateIs11kHzTest.o \
	../../PowerManagement/PowerManagementDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

Pie1Test.hex: $(OBJ_FILES) $(PIE1_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PIE1_OBJ_FILES)

Pir1Test.hex: $(OBJ_FILES) $(PIR1_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PIR1_OBJ_FILES)

AdcDisabledTest.hex: $(OBJ_FILES) $(ADC_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ADC_DISABLED_OBJ_FILES)

ChannelIs0VComparatorReferenceTest.hex: $(OBJ_FILES) $(CHANNEL_IS_0V_COMPARATOR_REFERENCE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CHANNEL_IS_0V_COMPARATOR_REFERENCE_OBJ_FILES)

LeftJustifiedTest.hex: $(OBJ_FILES) $(LEFT_JUSTIFIED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(LEFT_JUSTIFIED_OBJ_FILES)

VddAsVoltageReferenceTest.hex: $(OBJ_FILES) $(VDD_AS_VOLTAGE_REFERENCE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(VDD_AS_VOLTAGE_REFERENCE_OBJ_FILES)

SampleRateIs11kHzTest.hex: $(OBJ_FILES) $(SAMPLE_RATE_IS_11KHZ_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SAMPLE_RATE_IS_11KHZ_OBJ_FILES)

include $(MAKEFILE_RULES)
