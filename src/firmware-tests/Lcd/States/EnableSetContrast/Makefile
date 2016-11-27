HEX_FILES=\
	NextPollInChainTest.hex \
	NextStateTest.hex \
	EnableAdcTest.hex

OBJ_FILES+=\
	../../ShiftRegisterDummies.o \
	../../../Motor/MotorDummies.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterLcdMock.o \
	../../AdcDummies.o

NEXT_STATE_OBJ_FILES=\
	NextStateTest.o \
	../../PollAfterLcdDummy.o \
	../../AdcDummies.o

ENABLE_ADC_OBJ_FILES=\
	EnableAdcTest.o \
	../../PollAfterLcdDummy.o \
	../../AdcMocks.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateTest.hex: $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)

EnableAdcTest.hex: $(OBJ_FILES) $(ENABLE_ADC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_ADC_OBJ_FILES)

include $(MAKEFILE_RULES)
