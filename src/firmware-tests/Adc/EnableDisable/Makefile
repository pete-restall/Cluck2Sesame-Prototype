HEX_FILES=\
	EnableDisableAdcTest.hex \
	EnableAdcCalledTwiceTest.hex \
	EnableAdcCallsEnsureFastClockTest.hex \
	DisableAdcCallsAllowSlowClockTest.hex

ENABLE_DISABLE_ADC_OBJ_FILES=\
	EnableDisableAdcTest.o \
	../../PowerManagement/PowerManagementDummies.o

ENABLE_ADC_CALLED_TWICE_OBJ_FILES=\
	EnableAdcCalledTwiceTest.o \
	../../PowerManagement/PowerManagementDummies.o

ENABLE_ADC_CALLS_ENSURE_FAST_CLOCK_OBJ_FILES=\
	EnableAdcCallsEnsureFastClockTest.o \
	../../PowerManagement/PowerManagementMocks.o

DISABLE_ADC_CALLS_ALLOW_SLOW_CLOCK_OBJ_FILES=\
	DisableAdcCallsAllowSlowClockTest.o \
	../../PowerManagement/PowerManagementMocks.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableAdcTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_ADC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_ADC_OBJ_FILES)

EnableAdcCalledTwiceTest.hex: $(OBJ_FILES) $(ENABLE_ADC_CALLED_TWICE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_ADC_CALLED_TWICE_OBJ_FILES)

EnableAdcCallsEnsureFastClockTest.hex: $(OBJ_FILES) $(ENABLE_ADC_CALLS_ENSURE_FAST_CLOCK_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_ADC_CALLS_ENSURE_FAST_CLOCK_OBJ_FILES)

DisableAdcCallsAllowSlowClockTest.hex: $(OBJ_FILES) $(DISABLE_ADC_CALLS_ALLOW_SLOW_CLOCK_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_ADC_CALLS_ALLOW_SLOW_CLOCK_OBJ_FILES)

include $(MAKEFILE_RULES)
